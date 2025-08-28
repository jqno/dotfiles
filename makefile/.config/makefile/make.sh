#!/usr/bin/env bash

if [[ -f ".Makefile" ]]; then
  makefile_args=(-f "$HOME/.config/makefile/Makefile" -f ".Makefile")
else
  makefile_args=(-f "$HOME/.config/makefile/Makefile")
fi

if [[ $# == 0 || "$1" == "help" ]]; then
  # Show phony targets and their recipes, in alphabetical order
  echo "Available targets:"
  make -qp "${makefile_args[@]}" 2>/dev/null | awk '
    /^[^#[:space:]][^:]*:/ { target = $1; gsub(/:$/, "", target) }
    /^#.*Phony target/ { phony = 1 }
    /^[[:space:]][^#]/ && phony {
        gsub(/^[[:space:]]*/, "");
        targets[target] = $0;
        phony = 0
    }
    /^$/ { phony = 0 }
    END {
        PROCINFO["sorted_in"] = "@ind_str_asc";
        for (target in targets) printf "  \033[36m%-15s\033[0m : \033[32m%s\033[0m\n", target, targets[target]
    }
    '
  printf '  \033[36mhelp\033[0m            : \033[32mshows this page\033[0m\n'
else
  # Remove warnings written to stderr, but keep stdout intact to preserve coloring
  make -s "${makefile_args[@]}" "$@" 2> >(grep -v "warning:.*recipe" >&2)
fi
