import sys

cur = 0
arr = []
for line in sys.stdin:
    if len(line) > 1:
        cur += int(line)
    else:
        arr.append(cur)
        cur = 0

arr.sort()
print(arr)
