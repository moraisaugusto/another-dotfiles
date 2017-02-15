#!/usr/bin/env python3

import locale

locale.setlocale(locale.LC_ALL, "")
encoding = locale.getlocale()[1]

# ASCII range
for i in range(32, 128):
	seq = "".join("\{:o}".format(j) for j in chr(i + (1<<7)).encode(encoding))
	key = "{:#06X}".format(i)
	print("urxvt*keysym.Meta-{}: {}".format(key, seq))

