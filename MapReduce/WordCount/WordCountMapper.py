#!/usr/bin/env python
"""mapper.py"""

import sys

word_count = {'Dec': [0,0,0], 'hackathon': [0,0,0], 'Chicago': [0,0,0], 'Java': [0,0,0]}
words=['Dec','hackathon','Chicago','Java']
# input comes from STDIN (standard input)
# for f in sys.stdin:
lines=sys.stdin.readlines()
for word in words:
    word_lower=word.lower()
    for line in lines:
            # line=line.lower()    
            # remove leading and trailing whitespace
        line = line.strip()
        line=line.lower()
        if word_lower in line:
                # word=word.lower()
            print '%s\t%s' % (word, 1)
        else:
            print '%s\t%s' % (word, 0)

