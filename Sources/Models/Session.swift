import Foundation

struct Session {
    var startTs: Int64?
    var startDate: Date?
    var endDate: Date?
    var endTs: Int64?
    var notes: String?

    private func getCurrentTs() -> (currTs: TimeInterval, currDate: Date) {
        let currentDate = Date()
        let currTs = currentDate.timeIntervalSince1970
        let msSince1970 = TimeInterval(currTs * 1000)

        return (msSince1970, currentDate)
    }

    private func convertTimeIntervalToString() -> String {
        guard let endTs = endTs, let startTs = startTs else {
            return "Ongoing session"
        }

        var seconds = (endTs - startTs) / 1000
        let hours = seconds / 3600
        seconds = seconds % 3600

        let minutes = seconds / 60
        seconds = seconds % 60

        return "\(hours)hr \(minutes)min \(seconds)s"
    }

    mutating func start() {
        let timeInfo = getCurrentTs()
        startTs = Int64(timeInfo.currTs)
        startDate = timeInfo.currDate
    }

    mutating func end() {
        let timeInfo = getCurrentTs()
        endTs = Int64(timeInfo.currTs)
        endDate = timeInfo.currDate

        let timeString = convertTimeIntervalToString()
        print("Session Length: \(timeString)")
    }
}
