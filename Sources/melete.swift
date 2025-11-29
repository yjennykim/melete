// The Swift Programming Language
// https://docs.swift.org/swift-book
//
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser

@main
struct melete: ParsableCommand {
    func displayMenu() {
        print("melete Options")
        print("1. Start Session")
        print("2. End Session")
    }

    mutating func run() throws {
        let manager = SessionManager()
        displayMenu()

        while let line = readLine() {
            let number = Int(line.trimmingCharacters(in: .whitespacesAndNewlines))
            if number == 1 {
                manager.start()
            } else if number == 2 {
                manager.end()
            }

            displayMenu()
        }
    }
}
