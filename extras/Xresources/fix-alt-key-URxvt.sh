#!/usr/bin/env python3

import locale

locale.setlocale(locale.LC_ALL, "")
encoding = locale.getlocale()[1]
ignoredChars = ['f', 'b', 'ć']

print('!; mapping rxvt keys for alt work on vim')
print('!; ignored keys: ', end='')
print(', ' . join(ignoredChars))
print('!; http://www.unicodemap.org/search.asp?search=e\n\n')
# ASCII range
for i in range(32, 128):
	seq = "".join("\{:o}".format(j) for j in chr(i + (1<<7)).encode(encoding))
	key = "{:#06X}".format(i)
	if chr(i) not in ignoredChars:
		print("urxvt*keysym.Meta-{}: {}  // char {}".format(key, seq,chr(i)))
	else:
		print("!urxvt*keysym.Meta-{}: {}  // char {} REMOVED".format(key, seq,chr(i)))
	

