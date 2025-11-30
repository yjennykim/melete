// The Swift Programming Language
// https://docs.swift.org/swift-book
//
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser

@main
struct melete: ParsableCommand {
    func displayMenu(state: SessionState) {
        print("melete Options")

        switch state {
        case .notStarted:
            print("1. Start Session")
        case .paused:
            print("1. Resume Session")
        case .running:
            print("1. View Session (already running)")
        }

        print("2. Pause Session")
        print("3. End Session")
        print("X. Quit Melete")
    }

    mutating func run() throws {
        let manager = SessionManager()
        displayMenu(state: manager.state)

        while let line = readLine() {
            let number = Int(line.trimmingCharacters(in: .whitespacesAndNewlines))
            if number == 1 {
                if manager.state == .running {
                    manager.view()
                } else {
                    manager.start()
                }
            } else if number == 2 {
                manager.pause()
            } else if number == 3 {
                manager.end()
            } else {
                return
            }

            displayMenu(state: manager.state)
        }
    }
}
