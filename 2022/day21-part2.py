import sys

def calcExpressions(humn_value, expressions):
    used = {}
    humn = humn_value
    action = True
    while action:
        action = False
        for expression in expressions:
            if expression not in used:
                try:
                    exec(expression)
                    used[expression] = 1
                    action = True
                except Exception:
                    pass
    # Example root: pppw == sjmn
    # Input root: dbcq == zmvq
    return [eval('pppw'), eval('sjmn')]

def testState(humn_value, expessions):
    (a, b) = calcExpressions(humn_value, expressions)
    return 0 if (a == b) else 1 if (a > b) else -1

expressions = [line for line in sys.stdin]
solved = left = mid1 = mid2 = 0
right = 10000000000000

# Determines the state of the ternary search function: [-1, ... -1, 0, 1, ... 1] or with opposite signs.
ternary_state = 0 if testState(left, expressions) < testState(right, expressions) else 1

solved = False
while solved == False:
    mid1 = left + (right-left) // 3
    mid2 = left + 2 * (right-left) // 3
    first_value = testState(mid1, expressions)
    if first_value == 0:
        solved = True
    second_value = testState(mid2, expressions)

    if second_value == 0:
        solved = True

    if first_value != second_value:
        left = mid1
        right = mid2
    else:
        if ternary_state == 0:
            if first_value == -1:
                left = mid1
            else:
                right = mid2
        else:
            if first_value == -1:
                right = mid2
            else:
                left = mid1
