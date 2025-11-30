import Foundation

struct Session {
    var startTs: Int64?
    var startDate: Date?
    var endDate: Date?
    var endTs: Int64?
    var notes: String?
    var accumulatedTs: Int64 = 0

    private func getCurrentTs() -> (currTs: TimeInterval, currDate: Date) {
        let currentDate = Date()
        let currTs = currentDate.timeIntervalSince1970
        let msSince1970 = TimeInterval(currTs * 1000)

        return (msSince1970, currentDate)
    }

    private func getEndedSessionLengthAsString() -> String {
        var seconds = accumulatedTs / 1000
        let hours = seconds / 3600
        seconds = seconds % 3600

        let minutes = seconds / 60
        seconds = seconds % 60

        return "\(hours)hr \(minutes)min \(seconds)s"
    }

    func getCurrentDuration() -> String {
        var totalMs = accumulatedTs

        // If currently running, add time since last start/resume
        if let startTs = startTs {
            let timeInfo = getCurrentTs()
            totalMs += (Int64(timeInfo.currTs) - startTs)
        }

        var seconds = totalMs / 1000
        let hours = seconds / 3600
        seconds = seconds % 3600
        let minutes = seconds / 60
        seconds = seconds % 60

        return "\(hours)hr \(minutes)min \(seconds)s"
    }

    mutating func start() {
        let timeInfo = getCurrentTs()
        startTs = Int64(timeInfo.currTs)
        if startDate == nil {
            startDate = timeInfo.currDate
        }
    }

    mutating func end() {
        let timeInfo = getCurrentTs()
        endTs = Int64(timeInfo.currTs)
        endDate = timeInfo.currDate

        if let startTs = startTs {
            accumulatedTs += (Int64(timeInfo.currTs) - startTs)
        }
        let timeString = getEndedSessionLengthAsString()
    }

    mutating func pause() {
        // make sure start time is set
        guard let startTs = startTs else {
            print("Already paused...")
            return
        }
        let timeInfo = getCurrentTs()

        // add time since last start / resume
        accumulatedTs += (Int64(timeInfo.currTs) - startTs)

        // clear startTs to indicate pause
        self.startTs = nil
    }
}
