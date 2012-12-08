#!/bin/sh

cd `dirname $0`

# licensing at: http://folkets-lexikon.csc.kth.se/folkets/om.html
SVEN='http://folkets-lexikon.csc.kth.se/folkets/folkets_sv_en_public.xml'
ENSV='http://folkets-lexikon.csc.kth.se/folkets/folkets_en_sv_public.xml'
SYN='http://folkets2.nada.kth.se/synpairs.xml'

# -N only downloads if timestamp on file on server
# is more recent than timestamp on local file.
wget -N $SVEN
wget -N $ENSV
wget -N $SYN
