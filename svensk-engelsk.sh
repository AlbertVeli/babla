#!/bin/sh

usage()
{
    echo "Usage: $0 <word to translate>"
}

bail_out()
{
    printf "Error: $1\n"
    usage
    exit 1
}

srcword=${1}

if test "${srcword}" = ""; then
    bail_out 'no word to translate given'
fi

html2text --ignore-emphasis --ignore-links --ignore-images "http://sv.bab.la/lexikon/svensk-engelsk/${srcword}" 2>/dev/null | ./svensk-engelsk-helper.pl "${srcword}"
