///usr/bin/env jbang "$0" "$@" ; exit $?

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.stream.Collectors;

public class UnicodeConverter {

    public static void main(String... args) throws IOException {
        try {
            BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
            if (!reader.ready()) {
                printUsage();
                return;
            }

            String input = reader.lines().collect(Collectors.joining("\n"));

            var strings = input
                .chars()
                .mapToObj(UnicodeConverter::convertChar)
                .collect(Collectors.toList());

            var output = String.join("", strings);
            System.out.println(output);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static String convertChar(int c) {
        if (c == 10) {
            return "\n";
        } else {
            return "\\u00" + Integer.toHexString(c);
        }
    }

    private static void printUsage() {
        System.out.println(
            """
            Usage:

                UnicodeConverter <<EOF
                public class UnicodeEscapism {
                    public static void main(String... args) {
                        System.out.println("Hello hackers!");
                    }
                }
                EOF
            """.stripIndent()
        );
    }
}
