.PHONY: clean compile test verify format

PROJECT_TYPE := $(shell \
	(test -f mvnw && echo mvnw) || \
	(test -f pom.xml && echo maven) || \
	(test -f gradlew && echo gradlew) || \
	((test -f build.gradle || test -f build.gradle.kts) && echo gradle) || \
	(test -f build.sbt && echo sbt) || \
	(test -f package.json && echo node) || \
	echo unknown)

default: help

help:
	@echo "TODO: send help"

clean:
ifeq ($(PROJECT_TYPE),mvnw)
	./mvnw clean
else ifeq ($(PROJECT_TYPE),maven)
	mvn clean
else ifeq ($(PROJECT_TYPE),gradlew)
	./gradlew clean
else ifeq ($(PROJECT_TYPE),gradle)
	gradle clean
else ifeq ($(PROJECT_TYPE),sbt)
	sbt clean
else ifeq ($(PROJECT_TYPE),node)
	npm clean
else
	@echo "Unknown project type"
	exit 1
endif

compile:
ifeq ($(PROJECT_TYPE),mvnw)
	./mvnw test-compile
else ifeq ($(PROJECT_TYPE),maven)
	mvn test-compile
else ifeq ($(PROJECT_TYPE),gradlew)
	./gradlew testClasses
else ifeq ($(PROJECT_TYPE),gradle)
	gradle testClasses
else ifeq ($(PROJECT_TYPE),sbt)
	sbt test:compile
else ifeq ($(PROJECT_TYPE),node)
	npm run build
else
	@echo "Unknown project type"
	exit 1
endif

test:
ifeq ($(PROJECT_TYPE),mvnw)
	./mvnw test
else ifeq ($(PROJECT_TYPE),maven)
	mvn test
else ifeq ($(PROJECT_TYPE),gradlew)
	./gradlew test
else ifeq ($(PROJECT_TYPE),gradle)
	gradle test
else ifeq ($(PROJECT_TYPE),sbt)
	sbt test
else ifeq ($(PROJECT_TYPE),node)
	npm test
else
	@echo "Unknown project type"
	exit 1
endif

verify:
ifeq ($(PROJECT_TYPE),mvnw)
	./mvnw verify
else ifeq ($(PROJECT_TYPE),maven)
	mvn verify
else ifeq ($(PROJECT_TYPE),gradlew)
	./gradlew check
else ifeq ($(PROJECT_TYPE),gradle)
	gradle check
else ifeq ($(PROJECT_TYPE),sbt)
	sbt test
else ifeq ($(PROJECT_TYPE),node)
	npm run test
else
	@echo "Unknown project type"
	exit 1
endif

format:
ifeq ($(PROJECT_TYPE),mvnw)
	./mvnw spotless:apply
else ifeq ($(PROJECT_TYPE),maven)
	mvn spotless:apply
else ifeq ($(PROJECT_TYPE),gradlew)
	./gradlew spotlessApply
else ifeq ($(PROJECT_TYPE),gradle)
	gradle spotlessApply
else ifeq ($(PROJECT_TYPE),sbt)
	sbt scalafmtAll
else ifeq ($(PROJECT_TYPE),node)
	npm run format
else
	@echo "Unknown project type"
	exit 1
endif
