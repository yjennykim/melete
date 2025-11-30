import Foundation

class SessionManager {
    var currSession: Session?
    private(set) var state: SessionState = .notStarted  // private write, public read

    func start() {
        switch state {
        case .notStarted:
            currSession = Session()
            currSession?.start()
            state = .running
        case .paused:
            currSession?.start()
            state = .running
        default:
            print("Cannot start new session")
            return
        }
    }

    func view() {
        guard state == .running || state == .paused else {
            print("\nNo active session\n")
            return
        }

        let status = state == .running ? "🟢 Running" : "🟡 Paused"
        let duration = currSession?.getCurrentDuration() ?? "N/A"

        // Calculate width based on content
        let width = 40

        print("\n┌" + String(repeating: "─", count: width - 2) + "┐")
        print(
            "│" + " Current Session".padding(toLength: width - 2, withPad: " ", startingAt: 0) + "│"
        )
        print("├" + String(repeating: "─", count: width - 2) + "┤")
        print(
            "│" + " Status:   \(status)".padding(toLength: width - 2, withPad: " ", startingAt: 0)
                + "│")
        print(
            "│" + " Duration: \(duration)".padding(toLength: width - 2, withPad: " ", startingAt: 0)
                + "│")
        print("└" + String(repeating: "─", count: width - 2) + "┘\n")
    }

    func pause() {
        switch state {
        case .running:
            currSession?.pause()
            view()
            state = .paused
        default:
            print("Cannot pause session")
            return
        }
    }

    func end() {
        guard state == .running || state == .paused, currSession != nil else {
            print("Cannot end session")
            return
        }

        switch state {
        case .running:
            currSession?.end()
            currSession = nil
            state = .notStarted
        case .paused:
            currSession?.end()
            currSession = nil
            state = .notStarted
        default:
            print("Cannot end session")
            return
        }
    }
}
