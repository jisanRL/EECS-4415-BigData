# read from the stdin
# store them in a python dictionary 
# each dictionaries entry value as a counter to count the instance of the word 
# push the stopwords.txt file words into a dictionary
# compare any random input text file vs stopwords.txt 
# remove the stopwords in the input 
# plot the top ten words of the input 

import numpy as np
import matplotlib.pyplot as plot;plot.rcdefaults()
import os

# read from stopwords.txt and push into a list 
stopwordList = []
with open('stopwords-MySQL.txt') as f:
    stopwordList = [ln.strip() for ln in f]
    # for line in f:
    #     (key, val) = line.split()
    #     s[int(key)] = val
print('stopwordList=')
print(stopwordList)

# read from an input text and count occurances 
txt = open('file.txt')
dic = {}

for line in txt:
    line = line.strip()     # removes space and newline
    line = line.lower()    
    
    words = line.split(" ")  # splits line into words
    for wrd in words:
        if wrd in dic:      # check if word is in dic
            dic[wrd] = dic[wrd] + 1
        else:
            dic[wrd] = 1

for key in list(dic.keys()):
    print(key, ": ", dic[key])
    # None
# print("Dic=" + str(dic))

#plot the graph 
xAxis = [] 
yAxis = []

for value in dic.items():
    xAxis.append(value[0])             # get the key key of the dictionary/get the word 
    yAxis.append(dic[value[0]])     
print(yAxis)
print(xAxis)

yposition = np.arange(len(xAxis))
plot.bar(yposition, yAxis, align='center', alpha=0.5)
plot.xticks(yposition, xAxis)
plot.ylabel('#occurances')
plot.title('top ten usage')
plot.show()


# to-do
# 1. store the stopwords.txt into dictionary/list [done]
# 2. plot the graph 