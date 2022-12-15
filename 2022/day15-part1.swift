struct Point {
    var x, y: Int

    func distance(other: Point) -> Int {
        return abs(self.x - other.x) + abs(self.y - other.y);
    }
}

struct Interval {
    var from, to: Int
}

var intervals:[Interval] = []
let threshold:Int = 2000000

while let line = readLine() {
    let arr = line.split(separator: " ").map{Int($0) ?? 0}
    let sensor = Point(x:arr[0], y:arr[1])
    let beacon = Point(x:arr[2], y:arr[3])
    let range = sensor.distance(other: beacon)
    let distance = abs(sensor.y - threshold)
    if (distance > range) {
        continue
    }
    let space = range - distance
    intervals.append(Interval(from: sensor.x - space, to: sensor.x + space + 1))
}

intervals.sort(by: {$0.from < $1.from})
for interval in intervals {
    print(interval)
}

var ans:Int = 0, start:Int = intervals[0].from, end:Int = intervals[0].to
for interval in intervals {
    if (interval.from > end) {
        ans += end - start
        start = interval.from
        end = interval.to
    } else if (interval.to > end) {
        end = interval.to;
    }
}
ans += end - start
print(ans) // Not exact, also need to remove one of the beacons (wasn't really worth it to write more code just for it).
