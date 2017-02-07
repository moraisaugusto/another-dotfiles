#!/usr/bin/env python

import os
import time

frames = [
'''
          ,
         _|_
    -==<_-__|)
        _|_|_>
'''
,
'''
        __.__
         _|_
    \==<_-__|)
        _|_|_>
'''
,
'''
      ____.____
         _|_
    |==<_-__|)
        _|_|_>
'''
,
'''
        __,__
         _|_
    /==<_-__|)
        _|_|_>
'''
]

while True:
	for frame in frames:
            a = os.system('clear')
            print frame
            time.sleep(0.03)
