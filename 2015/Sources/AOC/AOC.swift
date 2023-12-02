import Foundation

enum MissingInputError: Error {
    case runtimeError(String)
}

class AOC {
    var input = ""

    init(name: String) {
        let fileURL = Bundle.main.url(forResource: "Problem\(name)",
                                      withExtension: "txt", subdirectory: "AOC_AOC2015.bundle")

        do {
            if fileURL == nil {
                throw MissingInputError.runtimeError("Could not load file!")
            }

            input = try String(contentsOf: fileURL!)
        } catch {}
    }

    func first() -> String {
        return "NOT IMPLEMENTED"
    }

    func second() -> String {
        return "NOT IMPLEMENTED"
    }
}
