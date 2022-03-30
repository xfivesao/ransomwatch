#!/bin/bash
# used to check each parser is returning findings
# run with -p to print the entailing shellcode

shell_parsers=`grep -A 2 "parser = '''" parsers.py | sed -e "/parser = '''/d" -e "/'''/d" -e '/^--$/d'`

if [ "${1}" == "-p" ]; then
    while read -r line; do
        if [[ ${line} =~ %s ]]; then
            line=${line//%s/grep -oE}
        fi
        echo ${line}
    done <<< "${shell_parsers}"
    exit 0
fi

while read -r line; do
    if [[ ${line} =~ %s ]]; then
        line=${line//%s/grep -oE}
    fi
    results=`echo "${line}" | bash`
    if [ -z "${results}" ]; then
        echo "error: broken"
        echo "${line}"
        echo ""
    fi
done <<< "$shell_parsers"
