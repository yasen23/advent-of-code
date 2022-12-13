import 'dart:io';

void main() {
    String? line;
    List<String> woods = [];
    while ((line = stdin.readLineSync()) != null) {
        woods.add(line!);
    }

    int n = woods.length, m = woods[0].length;
    final a = List.generate(
        n + 1,
        (i) => List.filled(m + 1,  0, growable: false), growable: false);

    int ans = 0;
    for (int i=1; i < n-1; ++i) {
        for (int j=1; j < m-1; ++j) {
            String max = woods[i][j];

            int x = i-1;
            while (max.compareTo(woods[x][j]) > 0 && x-1 >= 0) x --;
            int score = i-x;

            x = i+1;
            while (max.compareTo(woods[x][j]) > 0 && x+1 < n) x ++;
            score *= x-i;

            x = j-1;
            while (max.compareTo(woods[i][x]) > 0 && x-1 >= 0) x --;
            score *= j-x;

            x = j+1;
            while (max.compareTo(woods[i][x]) > 0 && x+1 < m) x ++;
            score *= x-j;

            if (score > ans) ans = score;
        }
    }

    print(ans);
}
