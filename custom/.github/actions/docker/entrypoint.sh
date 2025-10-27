#!/bin/sh -l

# `$#` expands to the number of arguments and `$@` expands to the supplied `args`
printf "Hello from Container:\n"
printf "Number of args: %d" "$#"
printf "\nArgs: "
printf "'%s' " "$@" "\n"
echo  "output-1=First Output Value" >> $GITHUB_OUTPUT

