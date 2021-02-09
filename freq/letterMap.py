#!/usr/bin/env python
# mapper for letters, processes the input data, maps the letters 
import sys
import re

ocr = 1
currentWord = None

# std input 
for i in sys.stdin:
    i = i.strip()
    wdc, cnt = i.split('\t',1)
    word, doc = wdc.split(' ', 1)

    if currentWord == word:
        ocr = ocr + 1
    else:
        ocr = 1
        currentWord = word
    print('%s#%s#%s#%s' % (word, ocr, doc, cnt))
