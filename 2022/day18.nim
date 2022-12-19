import os
import strutils
import tables
from sequtils import map

const
  Dimensions = 3
  Cubes = 4096
  States = 32768

type
  Cube = array[Dimensions, int]
  Droplet = array[Cubes, Cube]
  Queue = array[States, Cube]

var memo = initTable[Cube, int]()
var visited = initTable[Cube, int]()
var droplet : Droplet
var num = 0

while not endOfFile(stdin):
  var line: string = readLine(stdin)
  var point = line.split(" ").map(parseInt)
  droplet[num] = [point[0], point[1], point[2]]
  memo[droplet[num]] = 1
  num += 1

# Solution for part 1
var ans_pt1 = 0
for i in 0..num-1:
  var a : Cube = droplet[i]
  for j in 0..2:
    for k in [-1, 1]:
      a[j] += k
      if not memo.hasKey(a):
        ans_pt1 += 1
      a[j] -= k
echo ans_pt1

# Solution for part 2
const maxValue = 22
var ans = 0
var start = 0
var last = 0  # end is a keyword
var queue : Queue

queue[last] = [-1, -1, -1]
visited[[-1,-1,-1]] = 1
last += 1
while start < last:
  var cur = queue[start]
  start += 1
  for i in 0..2:
    for j in [-1, 1]:
      var a : Cube = cur
      a[i] += j
      if visited.hasKey(a):
        continue
      if memo.hasKey(a):
        ans += 1
        continue
      if a[i] < -1 or a[i] > maxValue:
        continue
      queue[last] = a
      last += 1
      visited[a] = 1

echo ans