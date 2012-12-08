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

syn_root = get_root(scriptdir + '/synpairs.xml')

synonyms = syn_root.findall('.//syn')
for s in synonyms:
    if s.findtext('w1') == word:
        print s.findtext('w2').encode('utf-8')
