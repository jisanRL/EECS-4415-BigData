import numpy as np
import matplotlib.pyplot as plot;plot.rcdefaults()
import os
import sys
import re

# read from stopwords.txt and push into a list 
stopwordList = []
with open('stopwords-MySQL.txt') as f:
    stopwordList = [ln.strip() for ln in f]
print('stopwordList=')
print(stopwordList)

# read from an input text and count occurances 
# txt = open('file.txt')
dic = {}

for line in sys.stdin:
    line = line.strip()             # removes space and newline
    line = line.lower()    
    
    # words = line.split(" ")                       # splits line into words
    words = filter(None, re.split('[\W+_]', line))  # seperating on white spaces
    words = map(lambda a:a.lower(), words)          # converting words to lowercase
    for wrd in words:
        if wrd not in stopwordList and len(wrd) != 1:  # check if word is a stopwrod or of lenght 1
            if wrd not in dic:                         # check if the word is in dic or not 
                dic[wrd] = 1
            else:
                dic[wrd] = dic[wrd] + 1


for key in list(dic.keys()):        # push the word and number of occurance in dictionary, where key=word and value=number of occurance
    print(key, ": ", dic[key])
    # None
print("Dic=" + str(dic))

#plot the graph 
xAxis = [] 
yAxis = []
topTen = sorted(dic.items(), key=lambda x:-x[1])[:10]        # sorts the 10 ten 

for value in topTen:
    xAxis.append(value[0])          # get the key key of the dictionary/get the word 
    yAxis.append(dic[value[0]])     
print(yAxis)
print(xAxis)

yposition = np.arange(len(xAxis))
plot.bar(yposition, yAxis, align='center', alpha=0.5)
plot.xticks(yposition, xAxis)
plot.ylabel('#occurances')
plot.title('top ten words')
plot.show()
