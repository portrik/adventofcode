class Problem03: AOC {
    init() {
        super.init(name: "03")
    }

    override func first() -> String {
        var houses: [String: Int] = [:]

        var posX = 0
        var posY = 0

        houses["0-0"] = 1

        for instruction in input {
            switch instruction {
            case "^":
                posY += 1
            case ">":
                posX += 1
            case "<":
                posX -= 1
            case "v":
                posY -= 1
            default:
                break
            }

            let position = "\(posX)-\(posY)"

            if houses[position] == nil {
                houses[position] = 0
            }

            houses[position] = houses[position]! + 1
        }

        return String(houses.count)
    }

    override func second() -> String {
        var houses: [String: Int] = [:]

        var santa = (0, 0)
        var robot = (0, 0)

        houses["0-0"] = 1

        for (index, instruction) in input.enumerated() {
            var direction = 0
            var alongX = true
            var position = ""

            switch instruction {
            case "^":
                direction = 1
                alongX = false
            case "v":
                direction = -1
                alongX = false
            case ">":
                direction = 1
                alongX = true
            case "<":
                direction = -1
                alongX = true
            default:
                break
            }

            if index % 2 == 0 {
                if alongX {
                    santa.0 += direction
                } else {
                    santa.1 += direction
                }

                position = "\(santa.0)-\(santa.1)"
            } else {
                if alongX {
                    robot.0 += direction
                } else {
                    robot.1 += direction
                }

                position = "\(robot.0)-\(robot.1)"
            }

            if houses[position] == nil {
                houses[position] = 0
            }

            houses[position] = houses[position]! + 1
        }

        return String(houses.count)
    }
}
