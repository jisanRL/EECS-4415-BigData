# reducer for letters, takes the ouput of the mapper 
# reduces and counts the letters 
import sys

currentLetter, ltr = None
currentCount = 0

# std input 
for i in sys.stdin:
    i = i.strip()                       # remove leading and trailing whitespaces 

    ltr, cnt = i.split('\t', 1)         # parse input 

    try:
        cnt = int(cnt)                  # convert the count to int 
    except ValueError:
        continue                        # count was not a number, so ignore 

    if currentLetter == ltr:
        currentCount += cnt
    else:
        if currentLetter:
            print('%s\t%s' % (currentLetter, currentCount))
        currentCount = cnt
        currentLetter = ltr

if currentLetter == ltr:
    print('%s\t%s' % (currentLetter, currentCount))         # output the last letter 
        
