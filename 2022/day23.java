import java.util.Scanner;

public class UnstableDiffusion {
    private static final int ROUNDS = 10;
    private static final int MAX_ROUNDS = 1000;
    private static final int MAX = 500;

    private static String[] grid = new String[MAX];
    private static int[][][] state = new int[MAX_ROUNDS][MAX][MAX];
    private static int n = 0, m, startX = 100, startY = 100;
    // Moves according to directions:  N, S, W, E.
    private static int[] dirx = {-1, 1,  0, 0};
    private static int[] diry = { 0, 0, -1, 1};
    private static int[][] movex = {{-1, -1, -1}, { 1, 1, 1}, {-1,  0,  1}, {-1, 0, 1}};
    private static int[][] movey = {{-1,  0,  1}, {-1, 0, 1}, {-1, -1, -1}, { 1, 1, 1}};

    static void readInput() {
        Scanner input = new Scanner(System.in);
        while (input.hasNextLine()) {
            grid[n++] = input.nextLine();
        }
        m = grid[0].length();
    }

    static void printGrid(int round) {
        for (int i=0; i < n + 5; ++i) {
            for (int j=0; j < m + 5; ++j)
                System.out.print(state[round][startX + i - 2][startY + j - 2]);
            System.out.println();
        }
    }

    static void initializeState() {
        for (int i=0; i < n; ++i)
            for (int j=0; j < m; ++j)
                state[0][startX + i][startY + j] = (grid[i].charAt(j) == '#') ? 1 : 0;
    }

    static void processRounds() {
        for (int round=0; round < MAX_ROUNDS; ++round) {
            // System.out.println("Grid at round " + round);
            // printGrid(round);
            boolean hasMove = false;
            for (int i=0; i < MAX; ++i)
                for (int j=0; j < MAX; ++j)
                    if (state[round][i][j] > 0) {
                        // First check if there are any occupied neighbouring cells.
                        int neighbourCount = 0;
                        for (int x=-1; x < 2; ++x)
                            for (int y=-1; y < 2; ++y)
                                if (x != 0 || y != 0)
                                    neighbourCount += state[round][i + x][j + y];
                        if (neighbourCount == 0) {
                            state[round + 1][i][j] = 1;
                            continue;
                        }
                        hasMove = true;
                        boolean found = false;
                        for (int move=0; move < 4; ++move) {
                            int occupiedCount = 0;
                            int direction = (move + round) % 4;
                            for (int k=0; k < 3; ++k) {
                                occupiedCount += state[round][i + movex[direction][k]][j + movey[direction][k]];
                            }
                            // System.out.println("For " + i + " " + j + " -> " + occupiedCount);
                            if (occupiedCount == 0) {
                                int nx = i + dirx[direction], ny = j + diry[direction];
                                found = true;
                                if (state[round + 1][nx][ny] == 1) {
                                    // Collision => stay in the same place and revert the other.
                                    state[round + 1][i][j] = 1;
                                    state[round + 1][nx][ny] = 0;
                                    nx += dirx[direction];
                                    ny += diry[direction];
                                    state[round + 1][nx][ny] = 1;
                                } else {
                                    state[round + 1][nx][ny] = 1;
                                }
                                break;
                            }
                        }
                        if (!found) {
                            state[round + 1][i][j] = 1;
                        }
                    }
            if (!hasMove) {
                System.out.println(round + 1);
                break;
            }
        }
    }

    static void findRectangle() {
        int minx = -1, maxx = -1, miny = -1, maxy = -1;
        for (int i=0; i < MAX; ++i)
            for (int j=0; j < MAX; ++j)
                if (state[ROUNDS][i][j] == 1) {
                    if (minx == -1 || minx > i) minx = i;
                    if (maxx == -1 || maxx < i) maxx = i;
                    if (miny == -1 || miny > j) miny = j;
                    if (maxy == -1 || maxy < j) maxy = j;
                }
        int ans = 0;
        for (int i=minx; i <= maxx; ++i)
            for (int j=miny; j <= maxy; ++j)
                ans += (1 - state[ROUNDS][i][j]);
        System.out.println(ans);
    }

    public static void main(String args[]) {
        readInput();
        initializeState();
        processRounds();
        findRectangle();
    }
}
