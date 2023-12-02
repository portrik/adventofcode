let solutions = [Problem01(), Problem02(), Problem03()]

let problem = (Int(CommandLine.arguments[1]) ?? 0) - 1
if problem < 0 || problem >= solutions.count {
    print("Unknown day '\(CommandLine.arguments[0])'!")
    exit(1)
}

print("Part one: \(solutions[problem].first())")
print("Second solution: \(solutions[problem].second())")
