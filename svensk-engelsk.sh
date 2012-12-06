#!/bin/sh

usage()
{
    echo "Usage: $0 <word to translate>"
}

bail_out()
{
    printf "$1\n"
    usage
    exit 1
}

srcword=${1}
scriptdir=`dirname $0`

if test "${srcword}" = ""; then
    for i in ${scriptdir}/*.sh; do
    basename $i .sh
    done
    bail_out '^^ choose one of the from-to combinations above'
fi

fromto=`basename $0 .sh`

/usr/bin/html2text --ignore-emphasis --ignore-links --ignore-images "http://sv.bab.la/lexikon/${fromto}/${srcword}" 2>/dev/null | \
${scriptdir}/svensk-engelsk-helper.pl "${srcword}"
