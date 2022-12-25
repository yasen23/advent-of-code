#include <iostream>
#include <vector>
#include <string>
#include <queue>
#define MAXM (1 << 7)
#define MAXN (1 << 5)
using namespace std;

string grid[MAXN];
const int DIRS = 4;
vector<pair<int, int>> blizzards[DIRS];
int dx[DIRS] = {0, 1,  0, -1};
int dy[DIRS] = {1, 0, -1,  0};
bool state[MAXN * MAXM][MAXN][MAXM], used[MAXN*MAXM];
bool visited[4][MAXN * MAXM][MAXN][MAXM];
int n, m, t, cycle, solvedFirstPart;

void read() {
    while (getline(cin, grid[n])) n++;
    m = grid[0].size();
    cycle = (n - 2) * (m - 2);
}

void captureBlizzards() {
    for (int i=0; i < n; ++i)
        for (int j=0; j < m; ++j) {
            switch(grid[i][j]) {
                case '>': blizzards[0].push_back({i, j}); break;
                case 'v': blizzards[1].push_back({i, j}); break;
                case '<': blizzards[2].push_back({i, j}); break;
                case '^': blizzards[3].push_back({i, j}); break;
                default: break;
            }
        }
    used[0] = 1;
    for (int i=0; i < DIRS; ++i)
        for (auto& blizzard : blizzards[i])
            state[0][blizzard.first][blizzard.second] = 1;
}

void updateState() {
    t ++;
    for (int i=0; i < DIRS; ++i)
        for (auto& blizzard : blizzards[i]) {
            int nx = blizzard.first + dx[i];
            int ny = blizzard.second + dy[i];
            if (nx == 0) nx = n - 2;
            if (nx + 1 == n) nx = 1;
            if (ny == 0) ny = m - 2;
            if (ny + 1 == m) ny = 1;
            blizzard = {nx, ny};
            state[t][nx][ny] = 1;
        }
}

void checkState(int curTime) {
    if (used[curTime % cycle]) return;
    used[curTime % cycle] = 1;
    updateState();
}

void solve() {
    captureBlizzards();
    queue<pair<int, int>> q;
    q.push({0, 1});
    visited[0][0][0][1] = 1;

    while (!q.empty()) {
        pair<int, int> cur = q.front();
        int curTime = cur.first;
        int curTrip = cur.second / (n*m);
        int curx = (cur.second % (n*m)) / m;
        int cury = (cur.second % (n*m)) % m;
        q.pop();
        // Check for final state.
        if (curTrip == 1 && !solvedFirstPart) {
            solvedFirstPart = true;
            printf("%d\n", curTime);
        }
        if (curTrip == 3) {
            printf("%d\n", curTime);
            return;
        }

        checkState(curTime + 1);
        int cyclicTime = (curTime + 1) % cycle;
        if (!state[cyclicTime][curx][cury] &&
            !visited[curTrip][cyclicTime][curx][cury]) {
                q.push({curTime + 1, cur.second});
            }
        for (int i=0; i < DIRS; ++i) {
            int nx = curx + dx[i];
            int ny = cury + dy[i];
            if (nx < 0 || nx >= n) continue;
            if (ny < 0 || ny >= m) continue;
            if (grid[nx][ny] == '#') continue;
            if (state[cyclicTime][nx][ny]) continue;
            int newTrip = curTrip;
            if (grid[nx][ny-1] == '#' && grid[nx][ny+1] == '#') {
                if (curTrip == 0 && nx > 0) newTrip ++;
                if (curTrip == 1 && nx == 0) newTrip ++;
                if (curTrip == 2 && nx > 0) newTrip ++;
            }
            if (visited[newTrip][cyclicTime][nx][ny]) continue;

            q.push({curTime + 1, newTrip * n * m + nx * m + ny});
            visited[newTrip][cyclicTime][nx][ny] = 1;
        }
    }
}

int main() {
    read();
    solve();
    return 0;
}
