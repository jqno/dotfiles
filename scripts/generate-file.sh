#!/usr/bin/env sh
# vim: noet:nosta:ts=2:sw=2:
# Note: for heredocs to work correctly, tabs must be used instead of spaces

case $1 in
	"scalafix")
		cat > .scalafix.conf <<-EOL
		rules = [OrganizeImports]
		
		OrganizeImports.groups = [
		  "re:javax?\\."
		  "*"
		  "scala."
		]
		EOL
		;;
esac

