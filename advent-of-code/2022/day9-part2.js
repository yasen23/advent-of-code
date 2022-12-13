const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

dir = {
    "L": [0, -1],
    "R": [0, 1],
    "U": [1, 0],
    "D": [-1, 0]
}

visited = {"0, 0": 1};
len = 10;
body = {
    0: [0, 0],
    1: [0, 0],
    2: [0, 0],
    3: [0, 0],
    4: [0, 0],
    5: [0, 0],
    6: [0, 0],
    7: [0, 0],
    8: [0, 0],
    9: [0, 0],
}

function isClose(x, y) {
    return Math.abs(x[0]-y[0]) < 2 && Math.abs(x[1]-y[1]) < 2;
}

function move(direction) {
    var oldHead = [body[0][0], body[0][1]];
    body[0][0] += dir[direction][0];
    body[0][1] += dir[direction][1];

    for (i=0; i+1 < len; ++i) {
        if (!isClose(body[i], body[i+1])) {
            var found = 0;
            Object.keys(dir).forEach(key => {
                var newx = body[i][0] + dir[key][0], newy = body[i][1] + dir[key][1];
                if (!found && isClose(body[i+1], [newx, newy])) {
                    body[i+1][0] = newx;
                    body[i+1][1] = newy;
                    found = 1;
                }
            });
            if (found == 0) {
                var dirr = {
                    "UL" : [-1, -1],
                    "UR" : [-1 , 1],
                    "DL" : [1, -1],
                    "DR" : [1, 1]
                };
                Object.keys(dirr).forEach(key => {
                    var newx = body[i][0] + dirr[key][0], newy = body[i][1] + dirr[key][1];
                    if (!found && isClose(body[i+1], [newx, newy])) {
                        body[i+1][0] = newx;
                        body[i+1][1] = newy;
                        found = 1;
                    }
                });
            }
        }
    }
    visited[body[len-1][0] + ", " + body[len-1][1]] = 1;
}

rl.on('line', (line) => {
    var direction = line[0];
    var value = parseInt(line.substring(2));
    for (let i=0; i < value; i++) {
        move(direction);
    }
});

rl.once('close', () => {
    var ans = 0;
    Object.keys(visited).forEach(key => {
        ans ++;
    });

    console.log(ans);
});
