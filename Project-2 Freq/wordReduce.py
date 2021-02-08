# reducers for letters
import sys

currentWord, word = None
currentCount = 0

# std input 
for i in sys.stdin:
    i = i.strip()                       # remove leading and trailing whitespaces 

    word, cnt = i.split('\t', 1)        # parse input 

    try:
        cnt = int(cnt)                  # convert the count to int 
    except ValueError:
        continue                        # count was not a number, so ignore 

    if currentWord == word:
        currentCount += cnt
    else:
        if currentWord:
            print('%s\t%s' % (currentWord, currentCount))
        currentCount = cnt
        currentWord = word

if currentWord == word:
    print('%s\t%s' % (currentWord, currentCount))         # output the last letter 