import RegexBuilder

let topMatcher = Regex {
    Capture {
        OneOrMore(.digit)
    }
    Capture {
        ChoiceOf {
            " red"
            " green"
            " blue"
        }
    }
}

var game = 1, total1 = 0, total2 = 0
while let line = readLine() {
    let matches = line.matches(of: topMatcher)
    let fixedBalls = [" red": 12, " green": 13, " blue": 14]
    var balls = [" red": 0, " green": 0, " blue": 0]
    var ok = 1

    for match in matches {
        let (_, amount, color) = match.output
        if (balls[String(color)] ?? 0 < Int(amount) ?? 0) {
            balls[String(color)] = Int(amount) ?? 0
        }
        if (fixedBalls[String(color)] ?? 0 < Int(amount) ?? 0) {
            ok = 0
        }
    }
    total1 += ok * game
    total2 += (balls[" red"] ?? 0) * (balls[" green"] ?? 0) * (balls[" blue"] ?? 0)
    game += 1
}
print("\(total1) \(total2)\n")
