#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>
using namespace std;

int cost[4][4], geodes = 0;
const int END_MINUTE = 32; // For part 1 use: 24.
// 0 -> ore, 1 -> clay, 2 -> obsidian, 3 -> geodes
unordered_set<long long> memo;

long long encode(int minutes, vector<int> &robots, vector<int> &resources) {
    long long ret = minutes;
    for (int i=0; i < robots.size(); ++i) ret = (ret << 7) + robots[i];
    for (int i=0; i < robots.size(); ++i) ret = (ret << 7) + resources[i];
    return ret;
}

void solve(int minute, vector<int> robots, vector<int> resources) {
    long long state = encode(minute, robots, resources);
    if (memo.count(state)) return;
    memo.insert(state);
    if (minute > 15) {
        int remaining = END_MINUTE-minute;
        int potential = robots[3] * remaining + (remaining / 2) * (remaining / 2 + 1) + 1;
        if (resources[3] + potential <= geodes)
            return;
    }
    if (minute == END_MINUTE) {
        if (resources[3] > geodes)
            geodes = resources[3];
        return;
    }
    vector<int> newResources(4);
    for (int i=0; i < 4; ++i) newResources[i] = resources[i] + robots[i];
    for (int i=3; i >= 0; --i) { // Always try with more expensive robots first.
        int canBuildRobot = true;
        for (int j=0; j < 4; ++j)
            if (resources[j] < cost[i][j])
                canBuildRobot = false;
        if (canBuildRobot) {
            robots[i] ++;
            for (int j=0; j < 4; ++j) newResources[j] -= cost[i][j];
            solve(minute + 1, robots, newResources);
            for (int j=0; j < 4; ++j) newResources[j] += cost[i][j];
            robots[i] --;
        }
    }
    // Just generate resources.
    solve(minute + 1, robots, newResources);
}

int main() {
    int ans = 1;
    while (cin) {
        std::string line;
        getline(cin, line);
        if (line.empty()) {
            break;
        }
        int blueprintId;
        memset(cost, 0, sizeof(cost));
        memo.clear();
        geodes = 0;
        sscanf(
            line.c_str(),
            "Blueprint %d: Each ore robot costs %d ore. "
            "Each clay robot costs %d ore. "
            "Each obsidian robot costs %d ore and %d clay. "
            "Each geode robot costs %d ore and %d obsidian.",
            &blueprintId, &cost[0][0],
            &cost[1][0], &cost[2][0], &cost[2][1],
            &cost[3][0], &cost[3][2]);

        solve(0, {1,0,0,0}, {0,0,0,0});
        // For part 1 use:  ans += blueprintId * geodes;
        ans *= geodes;
    }
    printf("%d\n", ans);
    return 0;
}
