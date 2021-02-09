#!/bin/bash

WCDIR=/home/freq
STREAMINGJAR=share/hadoop/tools/lib/hadoop-streaming-2.7.0.jar

printf "WORD MAP-REDUCE\n\n"
bin/hadoop jar $STREAMINGJAR                        \
    -files   $WCDIR/wordMap.py,$WCDIR/wordReduce.py \
    -mapper  $WCDIR/wordMap.py                      \
    -reducer $WCDIR/wordReduce.py                   \
    -input   Gutenberg/'*'                          \
    -output  Word

printf "\nLETTER MAP-REDUCE\n\n"
bin/hadoop jar $STREAMINGJAR                            \
    -files   $WCDIR/letterMap.py,$WCDIR/letterReduce.py \
    -mapper  $WCDIR/letterMap.py                        \
    -reducer $WCDIR/letterReduce.py                     \
    -input   Word/'*'                                   \
    -output  Freq
