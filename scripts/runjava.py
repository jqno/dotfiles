#!/usr/bin/env python3

"""Runs a Java program"""

import os
import re
import sys


CLASSPATH_DIR = ".vim"
CLASSPATH_FILE = f"{CLASSPATH_DIR}/classpath"
MAVEN_TARGET_DIR = "target/classes"
MAVEN_TARGET_TEST_DIR = "target/test-classes"


def main():
    argc = len(sys.argv)
    if argc == 1:
        print_help()
    elif sys.argv[1] == "-cp":
        generate_classpath()
    elif sys.argv[1] == "-c":
        compile_files(sys.argv[2:])
    elif sys.argv[1] == "-r":
        run_program(sys.argv[2], sys.argv[3:])
    else:
        print_help()


def print_help():
    print("Usage:")
    print("")
    print("*  runjava.py -r <filename> [<jvm-parameters> --] [<cmd-line parameters>]")
    print("")
    print("   Compiles the given filename if necessary, then runs it as a")
    print("   Java program against the generated classpath,")
    print("   with the given JVM parameters and command-line parameters,")
    print("   if present. Note that the JVM parameters must be followed by")
    print("   two dashes (--), even if no command-line parameters follow.")
    print("")
    print("")
    print("*  runjava.py -c <filename> [<filename>]...")
    print("")
    print("   Compiles the given files if necessary.")
    print("")
    print("")
    print("*  runjava.py -cp")
    print("")
    print("   Refreshes the generated classpath file.")
    print("")


def generate_classpath():
    print("Generating classpath...")
    if not os.path.exists(CLASSPATH_DIR):
        os.mkdir(CLASSPATH_DIR)
    cmd = f"""mvn -q org.codehaus.mojo:exec-maven-plugin:exec \
            -Dexec.classpathScope="test" \
            -Dexec.executable="echo" \
            -Dexec.args="%classpath" > {CLASSPATH_FILE}"""
    execute(cmd)


def compile_files(filenames):
    if not os.path.exists(CLASSPATH_FILE):
        generate_classpath()
    classpath = read_classpath()
    for filename in filenames:
        _, ext = os.path.splitext(filename)
        classname = determine_classname(filename)
        if ext == '.java' and is_stale(filename, determine_classfile(filename, classname)):
            compile_java_file(filename, classpath)


def run_program(filename, params):
    if not os.path.exists(CLASSPATH_FILE):
        generate_classpath()
    classpath = read_classpath()
    classname = determine_classname(filename)
    jvm_params, app_params = split_params(params)

    name, ext = os.path.splitext(filename)
    if ext == '.java' and is_stale(filename, determine_classfile(filename, classname)):
        compile_java_file(filename, classpath)
    if name.endswith("Test"):
        runner_params = determine_junit_runner_params(classpath, classname)
        run_java_class(runner_params[0], jvm_params, runner_params[1:] + app_params, classpath)
    else:
        run_java_class(classname, jvm_params, app_params, classpath)


def determine_classname(filename):
    packagename = determine_packagename(filename)
    basename = os.path.basename(filename)
    name, ext = os.path.splitext(basename)
    if ext == '.scala':
        return f"{packagename}.{name}$delayedInit$body"
    elif ext == '.kt':
        return f"{packagename}.{name}Kt"
    else:
        return f"{packagename}.{name}"


def determine_classfile(filename, classname):
    target = determine_target_dir(filename)
    replaced = classname.replace(".", "/")
    return f"{target}/{replaced}.class"


def determine_packagename(filename):
    with open(filename) as f:
        for line in f:
            if line.startswith("package"):
                return re.findall("^package ([A-Za-z_.]*);?$", line)[0]


def run_java_class(classname, compiler_params, app_params, classpath):
    joined_compiler_params = " ".join(compiler_params)
    joined_app_params = " ".join(app_params)
    cmd = f"java -cp {classpath} {joined_compiler_params} {classname} {joined_app_params}"
    execute(cmd)


def compile_java_file(filename, classpath):
    target = determine_target_dir(filename)
    cmd = f"javac -d {target} -cp {classpath} {filename}"
    execute(cmd)


def determine_target_dir(filename):
    if filename.startswith("src/test"):
        return MAVEN_TARGET_TEST_DIR
    else:
        return MAVEN_TARGET_DIR


def determine_junit_runner_params(classpath, classname):
    if "scalatest" in classpath:
        return ["org.scalatest.tools.Runner", "-oW", "-s", classname]
    elif "junit-platform-console" in classpath:
        return ["org.junit.platform.console.ConsoleLauncher", "--disable-ansi-colors", "--select-class", classname]
    elif "junit-jupiter-engine" in classpath:
        raise "When using JUnit 5, add junit-platform-console to your dependencies!"
    elif "junit/4." in classpath:
        return ["org.junit.runner.JUnitCore", classname]
    elif "junit/3." in classpath:
        return ["junit.textui.TestRunner", classname]
    else:
        raise "Can't figure out which unit test runner to use"


def read_classpath():
    with open(CLASSPATH_FILE) as f:
        return f.read().rstrip()


def split_params(params):
    jvm_params = []
    app_params = []
    for p in params:
        if p == "--":
            jvm_params = app_params
            app_params = []
        else:
            app_params.append(p)
    return (jvm_params, app_params)


def is_stale(first, second):
    try:
        first_time = os.path.getmtime(first)
        second_time = os.path.getmtime(second)
        return first_time > second_time
    except FileNotFoundError:
        return True


def execute(cmd):
    os.system(cmd)


if __name__ == "__main__":
    main()
