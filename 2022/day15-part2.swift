struct Point {
    var x, y: Int

    func distance(other: Point) -> Int {
        return abs(self.x - other.x) + abs(self.y - other.y);
    }
}

struct Interval {
    var from, to: Int
}

var sensors:[Point] = [], beacons:[Point] = []

while let line = readLine() {
    let arr = line.split(separator: " ").map{Int($0) ?? 0}
    sensors.append(Point(x:arr[0], y:arr[1]))
    beacons.append(Point(x:arr[2], y:arr[3]))
}

let limit = 4000000
for threshold in 0...limit {
    var intervals:[Interval] = []
    for (sensor, beacon) in zip(sensors, beacons) {
        let range = sensor.distance(other: beacon)
        let distance = abs(sensor.y - threshold)
        if (distance > range) {
            continue
        }
        let space = range - distance
        intervals.append(Interval(from: sensor.x - space, to: sensor.x + space + 1))
    }
    intervals.sort(by: {$0.from < $1.from})
    if (intervals.count > 0) {
        var start:Int = intervals[0].from, end:Int = intervals[0].to
        for interval in intervals {
            if (interval.from > end) {
                start = interval.from
                end = interval.to
            } else if (interval.to > end) {
                end = interval.to;
            }
        }
        if (start > 0) {
            print(threshold, start-1)
            print((start - 1) * limit + threshold)
        }
    }
}
