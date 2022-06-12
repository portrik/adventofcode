let problem = CommandLine.arguments[1]
let solution: AOC?

switch problem {
case "01":
    solution = Problem01()
case "02":
    solution = Problem02()
default:
    fatalError("Problem \(problem) is not implemented!")
}

print("Problem for day \(problem)")
print("First solution: \(solution!.first())")
print("Second solution: \(solution!.second())")
