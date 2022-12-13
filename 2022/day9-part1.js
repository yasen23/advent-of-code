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
head = [0, 0];
tail = [0, 0];

function isClose(x, y) {
    return Math.abs(x[0]-y[0]) < 2 && Math.abs(x[1]-y[1]) < 2;
}

function move(direction) {
    var oldHead = [head[0], head[1]];
    head[0] += dir[direction][0];
    head[1] += dir[direction][1];
    if (!isClose(head, tail)) {
        tail = oldHead;
        visited[tail[0] + ", " + tail[1]] = 1;
    }
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
