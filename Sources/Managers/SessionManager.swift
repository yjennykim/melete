import Foundation

class SessionManager {
    var currSession: Session?

    func start() {
        print("Started session")
        currSession = Session()
        currSession?.start()
    }

    func end() {
        guard var session = currSession else {
            print("No session ongoing")
            return
        }
        print("Ending session")
        session.end()
        currSession = nil
    }
}
