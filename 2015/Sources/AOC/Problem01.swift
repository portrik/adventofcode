class Problem01: AOC {
    init() {
        super.init(name: "01")
    }

    override func first() -> String {
        let upSteps = input.components(separatedBy: "(").count - 1
        let downSteps = input.components(separatedBy: ")").count - 1

        return String(upSteps - downSteps)
    }

    override func second() -> String {
        var current = 0
        var position = 0

        for char in input {
            current += char == "(" ? 1 : -1
            position += 1

            if current < 0 {
                break
            }
        }

        return String(position)
    }
}
