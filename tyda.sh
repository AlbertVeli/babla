#!/bin/sh

word=$1
scriptdir=`dirname $0`

if test "${word}" = ""; then
    echo "Usage: $0 <word to translate>"
    exit 1
fi

html2text --ignore-emphasis --ignore-links --ignore-images \
    http://tyda.se/search/${word} | \
    $scriptdir/tyda-helper.pl ${word}
