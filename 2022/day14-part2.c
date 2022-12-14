#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#define MAX 1024

char cave[MAX][MAX];

int ans = 0;
int maxDepth = 0;


void go(int x, int y) {
    if (y >= maxDepth) {
        return;
    }

    if (cave[x][y + 1] == ' ') go(x, y + 1);
    if (cave[x - 1][y + 1] == ' ') go(x - 1, y + 1);
    if (cave[x + 1][y + 1] == ' ') go(x + 1, y + 1);

    ans ++;
    cave[x][y] = '.';
}

int min(int a, int b) { return a < b? a : b; }
int max(int a, int b) { return a > b? a : b; }

int main() {
    memset(cave, ' ', sizeof(cave));
    int a, b, c, d;
    // Slightly modified input for easier parsing - no commas/arrows, rows ending with -1, -1 pairs.
    while (scanf("%d %d", &a, &b) > 0) { 
        maxDepth = max(maxDepth, b);
        for (;;) {
            scanf("%d %d", &c, &d);
            if (c == -1) break;

            maxDepth = max(maxDepth, d);
            for (int i=min(a, c); i <= max(a, c); ++i)
                for (int j=min(b, d); j <= max(b, d); ++j)
                    cave[i][j] = 'X';
            a = c; b = d;            
        }
    }
    maxDepth += 2;
    go(500, 0);
    printf("total steps = %d\n", ans);
}
