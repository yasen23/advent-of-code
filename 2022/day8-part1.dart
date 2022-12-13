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

    for (int i=0; i < n; ++i) {
        String max = woods[i][0];
        a[i][0] ++;
        for (int j=1; j < m; ++j) {
            if (max.compareTo(woods[i][j]) < 0) {
                a[i][j] ++;
                max = woods[i][j];
            }
        }

        max = woods[i][m-1];
        a[i][m-1] ++;
        for (int j=m-2; j >= 0; --j) {
            if (max.compareTo(woods[i][j]) < 0) {
                a[i][j] ++;
                max = woods[i][j];
            }
        }
    }
    for (int j=0; j < m; ++j) {
        String max = woods[0][j];
        a[0][j] ++;
        for (int i=1; i < n; ++i) {
            if (max.compareTo(woods[i][j]) < 0) {
                a[i][j] ++;
                max = woods[i][j];
            }
        }

        max = woods[n-1][j];
        a[n-1][j] ++;
        for (int i=n-2; i >= 0; --i) {
            if (max.compareTo(woods[i][j]) < 0) {
                a[i][j] ++;
                max = woods[i][j];
            }
        }
    }

    int ans = 0;
    for (int i=0; i < n; ++i)
        for (int j=0; j < m; ++j)
            if (a[i][j] > 0)
                ans ++;
    print(ans);
}
