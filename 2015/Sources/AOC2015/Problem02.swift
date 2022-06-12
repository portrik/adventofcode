class Problem02: AOC {
    var dimensions: [[Int]] = []

    init() {
        super.init(name: "02")

        if input.count > 0 {
            let lines = input.components(separatedBy: "\n").filter { line in line.count > 0 }

            for line in lines {
                let rawNumbers = line.components(separatedBy: "x")
                dimensions.append([Int(rawNumbers[0]) ?? 0, Int(rawNumbers[1]) ?? 0, Int(rawNumbers[2]) ?? 0])
            }
        }
    }

    override func first() -> String {
        var total = 0

        for gift in dimensions {
            let fixed = 2 * gift[0] * gift[1] + 2 * gift[1] * gift[2] + 2 * gift[2] * gift[0]

            var sortable = gift
            sortable.sort()
            let slack = sortable[0] * sortable[1]

            total += fixed + slack
        }

        return String(total)
    }

    override func second() -> String {
        var total = 0

        for gift in dimensions {
            var sortable = gift
            sortable.sort()

            let fixed = 2 * gift[0] + 2 * gift[1]
            let bow = gift[0] * gift[1] * gift[2]

            total += fixed + bow
        }

        return String(total)
    }
}
