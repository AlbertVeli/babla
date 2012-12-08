#!/bin/sh

# html2text --ignore-emphasis --ignore-links 'http://folkets-lexikon.csc.kth.se/folkets/service?word=mother&lang=en&interface=sv'
echo "$*" | netcat localhost 3133 | sort | uniq
