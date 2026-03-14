# AGENTS.md

## Way of working

- Favor minimalism and simplicity. Don't add code unless it's necessary.
- After every file edit, automatically run `just test` (or `mvn test` if a Maven project) before responding, without asking for permission. If the test fails, take appropriate action.

## Dev environment

- Use `just` commands if a @justfile or @.justfile is present.
- In a Java/Scala/Kotlin project, never use `mvn install` unless explicitly asked.

## Coding style

- Prefer a functional style over an imperative.
