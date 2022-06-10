class Problem01: AOC {
    override func first() -> String {
        let up = input.components(separatedBy: "(").count - 1
        let down = input.components(separatedBy: ")").count - 1

        return String(up - down)
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
