# read from the stdin
# store them in a python dictionary 
# each dictionaries entry value as a counter to count the instance of the word 
# push the stopwords.txt file words into a dictionary
# compare any random input text file vs stopwords.txt 
# remove the stopwords in the input 
# plot the top ten words of the input 

import numpy as np
import matplotlib.pyplot as plot
import os

# read from stopwords.txt and push into dixtionary 
# s = {}
# key = ""
# with open('stopwords-MySQL.txt') as f:
#     for line in f:
#         (key, val) = line.split()
#         s[int(key)] = val
# print(s)

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


