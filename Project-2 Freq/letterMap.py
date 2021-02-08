# mapper for letters, processes the input data
# maps the letters 
import sys
import re

# std input 
for i in sys.stdin:
    i = i.strip()

    wrd, cnt = i.split('\t', 1)
    ltr = re.sub('[^a-zA-Z]+', '', wrd)

    if len(ltr) > 0:
        print('%s\t%s' % (ltr[0], cnt))



# for i in range(4):
#     print("Hello")