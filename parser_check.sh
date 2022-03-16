#!/bin/bash

shell_parsers=`grep -A 2 "parser = '''" parsers.py | sed -e "/parser = '''/d" -e "/'''/d" -e '/^--$/d'`

while read -r line; do
    # if line contains %s replace it with "grep -oE"
    if [[ $line =~ %s ]]; then
        line=${line//%s/grep -oE}
    fi
    results=`echo "$line" | bash`
    if [ -z "$results" ]; then
        echo "error: broken"
        echo "$line"
        echo ""
    fi
done <<< "$shell_parsers"
