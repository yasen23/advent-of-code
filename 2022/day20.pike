array(int) value = ({});
array(int) nxt = ({});
array(int) prv = ({});
int n=0, a=0;

void move(int i) {
    int item = value[i] % (n-1);
    int times = abs(item % (n-1)), cur = i;
    if (item != 0) {
        if (item < 0) times ++;
        while (times --> 0) {
            cur = (item > 0)? nxt[cur] : prv[cur];
        }
        // Rewire :)
        nxt[prv[i]] = nxt[i];
        prv[nxt[i]] = prv[i];
        prv[i] = cur;
        nxt[i] = nxt[cur];
        prv[nxt[cur]] = i;
        nxt[cur] = i;
    }
}

int main() {
	string line;
	while (line = Stdio.stdin->gets()) {
	  sscanf(line, "%d", a);
	  value += ({a});
	  prv += ({0});
	  nxt += ({0});
	  n ++;
    }
     for (int i=0; i < n; ++i) {
        prv[i] = (i - 1) % n;
        if (prv[i] < 0) prv[i] += n;
        nxt[i] = (i + 1) % n;
        // For part 2:  value[i] *= 811589153LL;
    }
    // For part 2:  for (int times=0; times < 10; ++times)
	for (int i=0; i < n; ++i) {
        move(i);
    }

    int sum = 0, cur = 0;
    for (int i=0; i < n; ++i)
        if (value[i] == 0)
            cur = i;
    for (int j=0; j < 3; ++j) {
        for (int i=0; i < 1000; ++i) cur = nxt[cur];
        sum += value[cur];
    }
    write("%d\n", sum);
	return 0;
}
