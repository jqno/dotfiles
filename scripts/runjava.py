#!/usr/bin/env python3

"""Runs a Java program"""

import os
import re
import sys
from pathlib import Path


CLASSPATH_DIR = ".vim"
CLASSPATH_FILE = f"{CLASSPATH_DIR}/classpath"
MAVEN_TARGET_DIR = "target/classes"
MAVEN_TARGET_TEST_DIR = "target/test-classes"

EXT_TO_COMPILER = {
    '.java': 'javac',
    '.scala': 'scalac'
}


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
    log("Generating classpath...")
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
        if ext in [".java", ".scala"]:
            classname = determine_classname(filename, False)
            if is_stale(filename, determine_classfile(filename, classname)):
                compile_file(filename, classpath)


def run_program(filename, params):
    if not os.path.exists(CLASSPATH_FILE):
        generate_classpath()
    classpath = read_classpath()
    jvm_params, app_params = split_params(params)

    name, _ = os.path.splitext(filename)
    if is_stale(filename, determine_classfile(filename, determine_classname(filename, False))):
        compile_file(filename, classpath)

    classname = determine_classname(filename, True)
    if name.endswith("Test"):
        runner_params = determine_junit_runner_params(classpath, classname)
        run_java_class(
            runner_params[1],
            jvm_params,
            runner_params[2:] + app_params,
            runner_params[0])
    else:
        run_java_class(classname, jvm_params, app_params, classpath)


def determine_classname(filename, find_main):
    packagename = determine_packagename(filename)
    basename = os.path.basename(filename)
    name, ext = os.path.splitext(basename)
    if ext == '.scala' and find_main:
        return f"{packagename}.{name}$delayedInit$body"
    if ext == '.kt' and find_main:
        return f"{packagename}.{name}Kt"
    return f"{packagename}.{name}"


def determine_classfile(filename, classname):
    target = determine_target_dir(filename)
    replaced = classname.replace(".", "/")
    return f"{target}/{replaced}.class"


def determine_packagename(filename):
    with open(filename) as file:
        for line in file:
            if line.startswith("package"):
                return re.findall("^package ([A-Za-z_.]*);?$", line)[0]
    raise Exception("Could not determine package name")


def run_java_class(classname, compiler_params, app_params, classpath):
    log(f"Running class {classname}...")
    log("")
    joined_compiler_params = " ".join(compiler_params)
    joined_app_params = " ".join(app_params)
    cmd = f"java -cp {classpath} {joined_compiler_params} {classname} {joined_app_params}"
    execute(cmd)


def compile_file(filename, classpath):
    log(f"Compiling stale file {os.path.basename(filename)}...")
    _, ext = os.path.splitext(filename)
    compilername = EXT_TO_COMPILER.get(ext, 'javac')
    target = determine_target_dir(filename)
    cmd = f"{compilername} -d {target} -classpath {classpath} {filename}"
    execute(cmd)


def determine_target_dir(filename):
    if filename.startswith("src/test"):
        return MAVEN_TARGET_TEST_DIR
    return MAVEN_TARGET_DIR


def determine_junit_runner_params(classpath, classname):
    if "scalatest" in classpath:
        return [classpath, "org.scalatest.tools.Runner", "-oW", "-s", classname]
    if "junit-jupiter-engine" in classpath:
        new_classpath = classpath
        if "junit-platform-console" not in new_classpath:
            junit5_cp = determine_junit5_runner_location()
            if junit5_cp is None:
                msg = "Could not find junit-platform-console in your dependencies " + \
                      "or in your local repository."
                raise Exception(msg)
            new_classpath = f"{classpath}:{junit5_cp}"
        return [new_classpath,
                "org.junit.platform.console.ConsoleLauncher",
                "--disable-ansi-colors",
                "--select-class",
                classname]
    if "junit/4." in classpath:
        return [classpath, "org.junit.runner.JUnitCore", classname]
    if "junit/3." in classpath:
        return [classpath, "junit.textui.TestRunner", classname]
    raise Exception("Can't figure out which unit test runner to use")


def determine_junit5_runner_location():
    junit_path = os.path.join(
        Path.home(),
        ".m2/repository/org/junit/platform")
    junit_console_path = os.path.join(junit_path, "junit-platform-console")
    junit_launcher_path = os.path.join(junit_path, "junit-platform-launcher")
    if not os.path.isdir(junit_console_path):
        return None
    versions = sorted(filter(lambda s: s[0].isdigit(), os.listdir(junit_console_path)))
    if len(versions) == 0:
        return None
    version = versions[-1]
    jars = [os.path.join(junit_console_path, version, f"junit-platform-console-{version}.jar"),
            os.path.join(junit_launcher_path, version, f"junit-platform-launcher-{version}.jar")]
    return ':'.join(jars)


def read_classpath():
    with open(CLASSPATH_FILE) as file:
        return file.read().rstrip()


def split_params(params):
    jvm_params = []
    app_params = []
    for param in params:
        if param == "--":
            jvm_params = app_params
            app_params = []
        else:
            app_params.append(param)
    return (jvm_params, app_params)


def is_stale(first, second):
    try:
        first_time = os.path.getmtime(first)
        second_time = os.path.getmtime(second)
        return first_time > second_time
    except FileNotFoundError:
        return True


def log(message):
    print(message, flush=True)


def execute(cmd):
    os.system(cmd)


if __name__ == "__main__":
    main()
