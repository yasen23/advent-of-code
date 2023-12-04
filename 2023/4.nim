import strutils
import std/math
import std/tables

var
  answerPart1 = 0
  answerPart2 = 0
  additionalCards = initTable[int, int]()
  card = 0

while not endOfFile(stdin):
  var
    line: string = readLine(stdin)
    winningNumbers = newSeq[int]()
    memorize = true
    matches = 0

  if not additionalCards.hasKey(card):
    additionalCards[card] = 0
  inc additionalCards[card]

  for word in tokenize(line):
    if word.token == "|":
      memorize = false
    else:
      if word.isSep or not isDigit(word.token[^1]):
        continue

      var number = parseInt(word.token)
      if memorize:
        winningNumbers.add(number)
      else:
        if find(winningNumbers, number) != -1:
          inc matches

  if matches > 0:
    answerPart1 += 2 ^ (matches - 1)
    while matches > 0:
      if not additionalCards.hasKey(card + matches):
        additionalCards[card + matches] = 0
      additionalCards[card + matches] += additionalCards[card]
      dec matches
  answerPart2 += additionalCards[card]
  inc card

writeLine(stdout, answerPart1)
writeLine(stdout, answerPart2)
