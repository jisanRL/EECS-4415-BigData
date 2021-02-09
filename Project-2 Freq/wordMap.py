#!/usr/bin/env python
# mapper for words
import sys
import re
import os

# stdin input 
for i in sys.stdin:
    i = i.strip()                               # remove leading and trailing 

    wrds = filter(None, re.split('[\W+_]', i))     # split the line into words 

    # write out word paired with count of 1 
    for word in wrds:                   
        print('%s %s\t%s' % (word.lower(), 1))     # write the results to stdout 
