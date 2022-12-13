#!/usr/bin/env Rscript

con=file("stdin", "r")

ans = 0
while (TRUE) {
    x = scan(file=con, what="integer", n=1)
    y = scan(file=con, what="integer", n=1)
    c = scan(file=con, what="integer", n=1)
    d = scan(file=con, what="integer", n=1)

    if (identical(x, character(0))) {
        break
    }
    x = as.integer(x)
    y = as.integer(y)
    c = as.integer(c)
    d = as.integer(d)

    if ((x <= c & c <= y) | (x <= d & d <= y)) {
        ans = ans + 1
    } else if ((c <= x & x <= d) | (c <= y & y <= d)) {
        ans = ans + 1
    }
}

print(ans)
