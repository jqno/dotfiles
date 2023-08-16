local ls = require('luasnip')
local parse = ls.parser.parse_snippet

return {
    parse({ trig = 'start', dscr = 'Start a new file' },
        [[
        <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
            <modelVersion>4.0.0</modelVersion>
            <groupId>$1</groupId>
            <artifactId>$2</artifactId>
            <packaging>${3|jar,pom|}</packaging>

            <name>$4</name>
            <version>${5:0.1-SNAPSHOT}</version>
            <description>$6</description>

            <properties>
                $7
            </properties>

            <dependencies>
                $8
            </dependencies>

            <build>
                <plugins>
                    $9
                </plugins>
            </build>

            <reporting>
                <plugins>
                    $10
                </plugins>
            </reporting>
        </project>
        ]]),
    parse({ trig = 'parent', dscr = '<parent>' },
        [[
        <parent>
            <groupId>$1</groupId>
            <artifactId>$2</artifactId>
            <version>$3</version>
        </parent>
        ]]),
    parse({ trig = 'properties', dscr = '<properties>' },
        [[
        <properties>
            $1
        </properties>
        ]]),
    parse({ trig = 'repository', dscr = '<repository>' },
        [[
        <repository>
            <id>$1</id>
            <url>$1</url>
        </repository>
        ]]),
    parse({ trig = 'dependency', dscr = '<dependency>' },
        [[
        <dependency>
            <groupId>$1</groupId>
            <artifactId>$2</artifactId>
            <version>$3</version>
        ${4:    <scope>test</scope>}
        </dependency>
        ]]),
    parse({ trig = 'plugin', dscr = '<plugin>' },
        [[
        <plugin>
            <groupId>$1</groupId>
            <artifactId>$2</artifactId>
            <version>$3</version>
        </plugin>
        ]]),
    parse({ trig = 'configuration', dscr = '<configuration>' },
        [[
        <configuration>
            $1
        </configuration>
        ]]),
    parse({ trig = 'executions', dscr = '<executions>' },
        [[
        <executions>
            <execution>
                <id>$1</id>
                <phase>$2</phase>
                <goals>
                    <goal>$3</goal>
                </goals>
            </execution>
            $4
        </executions>
        ]]),
    parse({ trig = 'execution', dscr = '<execution>' },
        [[
        <execution>
            <id>$1</id>
            <phase>$2</phase>
            <goals>
                <goal>$3</goal>
            </goals>
        </execution>
        ]]),
    parse({ trig = 'profiles', dscr = '<profiles>' },
        [[
        <profiles>
            <profile>
                <id>$1</id>
                <activation>
                    $2
                </activation>
                $3
            </profile>
            $4
        </profiles>
        ]]),
    parse({ trig = 'profile', dscr = '<profile>' },
        [[
        <profile>
            <id>$1</id>
            <activation>
                $2
            </activation>
            $3
        </profile>
        ]])
}
