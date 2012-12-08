#!/usr/bin/env python

import sys
import urllib
import SocketServer
import xml.etree.cElementTree as etree

debug = True
def dbg(msg):
    if debug:
        print msg

def get_root(xmlfile):
    dbg('parsing xml')
    tree = etree.parse(xmlfile)
    dbg('done')
    root = tree.getroot()
    return root

# Save port in global variable
try:
    portno = int(sys.argv[1])
except:
    print 'usage: %s [portno]' % sys.argv[0]
    portno = 3133
    print 'defaulting to port %d' % portno

print 'Starting folkets lexikon server at port %d' % portno

# Parse xml tree just once (takes time)
# Save root in global variable
the_root = get_root('folkets_sv_en_public.xml')

class MyTCPHandler(SocketServer.StreamRequestHandler):

    # This is run each time a new connection is made to port
    def handle(self):
        self.data = self.rfile.readline().strip()
        word = self.data.decode('utf-8')
        print "{}> ".format(self.client_address[0]) + word
        # Search for all subelements 'translation' of
        # elements with value="%s" % word
        srchstr = ".//*[@value='%s']/translation" % word
        translations = the_root.findall(srchstr)
        for t in translations:
            trans = t.attrib['value']
            print "> %s" % trans
            self.wfile.write(trans + '\n')

if __name__ == "__main__":

    host = 'localhost'
    server = SocketServer.TCPServer((host, portno), MyTCPHandler)

    # Run until Ctrl-C
    server.serve_forever()
