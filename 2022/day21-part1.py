import sys

expressions = [line for line in sys.stdin]

used = {}
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

exec('print(root)')
