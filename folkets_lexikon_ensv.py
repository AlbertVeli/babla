#!/usr/bin/env python

import os
import sys
import xml.etree.cElementTree as etree

debug = False
def dbg(msg):
    if debug:
        print msg

def get_root(xmlfile):
    dbg('parsing xml')
    tree = etree.parse(xmlfile)
    dbg('done')
    root = tree.getroot()
    return root

# Get word from cmdline
try:
    scriptdir = os.path.dirname(sys.argv[0])
    word = sys.argv[1]
    word = word.decode('utf-8')
except:
    print 'usage: %s <word>' % sys.argv[0]
    sys.exit(1)

ensv_root = get_root(scriptdir + '/folkets_en_sv_public.xml')

srchstr = ".//*[@value='%s']/translation" % word
translations = ensv_root.findall(srchstr)

trans = []
for t in translations:
    trans.append(t.attrib['value'])

# Sort and remove duplicates
trans = list(set(trans))

for t in trans:
    print t.encode('utf-8')
