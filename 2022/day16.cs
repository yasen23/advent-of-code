using System;

public class ProboscideaVolcanium {
    private static Dictionary<string, int> memo = new Dictionary<string, int>();
    private static Dictionary<string, int> nodes = new Dictionary<string, int>();
    private static int[] scores = new int[64];
    private static List<int> nonZeroScores = new List<int>();
    private static List<int>[] neighbours = new List<int>[64];
    private static int ans = 0, numNodes = 0, maxScore = 0;

    private static int node(string nodeString) {
        if (nodes.ContainsKey(nodeString)) {
            return nodes[nodeString];
        }
        nodes[nodeString] = numNodes;
        neighbours[numNodes] = new List<int>();
        return numNodes++;
    }

    // Solution for part 1.
    private static void go(int minute, int node, int score, long openValves) {
        string state = string.Format("{0},{1},{2}", minute, node, openValves);
        if (memo.ContainsKey(state) && memo[state] >= score) return;
        memo[state] = score;
        if (score > ans) ans = score;
        if (minute == 30) return;

        if (scores[node] > 0 && (openValves & (1L << node)) == 0) {
            go(minute+1, node, score + (30-minute-1) * scores[node], openValves | (1L << node));
        }
        foreach (int neighbour in neighbours[node]) {
            go(minute+1, neighbour, score, openValves);
        }
    }

    // Solution for part 2.
    private static void goWithElephant(int minute, int move, int node, int nodeElephant, int score, long openValves) {
        string state = string.Format("{0},{1},{2},{3},{4}", minute, move, node, nodeElephant, openValves);
        if (memo.ContainsKey(state) && memo[state] >= score) return;
        memo[state] = score;
        if (score > ans) {
            ans = score;
            Console.WriteLine(ans);
        }
        if (minute == 26 && move == 1) return;

        if (minute > 10) {
            // Do some pruning...
            int times = (26 - minute - 1) / 2;
            int total = times * (times + 1);
            if (score + maxScore * total < ans)
                return;
        }

        int currentNode = (move == 0) ? node : nodeElephant;
        if (scores[currentNode] > 0 && (openValves & (1L << currentNode)) == 0) {
            int newScore = score + (26-minute-1) * scores[currentNode];
            goWithElephant(minute + move, 1 - move, node, nodeElephant, newScore, openValves | (1L << currentNode));
        }

        foreach (int neighbour in neighbours[currentNode]) {
            if (move == 0) {
                goWithElephant(minute + move, 1 - move, neighbour, nodeElephant, score, openValves);
            } else {
                goWithElephant(minute + move, 1 - move, node, neighbour, score, openValves);
            }
        }
    }

    public static void Main(string[] args) {
        FileInfo sourceFile = new FileInfo(@"./16.in");
        TextReader sourceFileReader = new StreamReader(sourceFile.FullName);
        Console.SetIn(sourceFileReader);

        string line = null;
        while ((line = Console.ReadLine()) != null) {
            int currentNode = node(line);
            scores[currentNode] = int.Parse(Console.ReadLine());
            line = Console.ReadLine();
            string[] adjacentNodes = line.Split(' ');
            foreach (string nodeString in adjacentNodes) {
                int neighbourNode = node(nodeString);
                neighbours[currentNode].Add(neighbourNode);
            }
        }
        for (int i=0; i < numNodes; ++i) {
            if (scores[i] > maxScore)
                maxScore = scores[i];
        }
        goWithElephant(0, 0, node("AA"), node("AA"), 0, 0);
        Console.WriteLine(ans);
    }
}
