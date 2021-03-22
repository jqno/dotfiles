#!/usr/bin/env sh
# vim: noet:nosta:ts=2:sw=2:
# Note: for heredocs to work correctly, tabs must be used instead of spaces

case $1 in
	"scalafix")
		cat > .scalafix.conf <<-EOF
		rules = [OrganizeImports]
		
		OrganizeImports.groups = [
		  "re:javax?\\\\."
		  "*"
		  "scala."
		]
		EOF
		;;
	"gitignore")
		cat > .gitignore <<-EOF
		# Maven
		target
		pom.xml.versionsBackup
		dependency-reduced-pom.xml

		# IDE
		.idea
		*.iml
		.project
		.classpath
		.settings

		# OS
		.DS_Store
		EOF
		;;
	*)
		echo "Unknown file type: [$1]"
esac

