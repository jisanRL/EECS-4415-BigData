#!/usr/bin/env python
# reducer for letters, takes the ouput of the mapper 
# reduces and counts the letters 
import sys
import re 
from math import log

currentLetter = None
freq = 0
ltr = None
currentCount = 0

# std input 
for i in sys.stdin:
    i = i.strip()                       # remove leading and trailing whitespaces 

    wrd, vc = i.split('#', 1)
    freqX, cf = vc.split('#', 1)
    file, cnt = cf.split('#', 1)

    # ltr, cnt = i.split('\t', 1)         # parse input 

    if wrd == currentLetter:
        a = float(cnt) * log(20/float(freq))
        print('%s, %s\t%s' %(wrd, file, a))
    else:
        currentLetter = wrd
        freq = freqX
        a = float(cnt) * log(20/float(freq))
        print('%s,%s\t%s' %(wrd, file, a))