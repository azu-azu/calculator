import Foundation

extension Calendar {
    func businessDaysBetween(from start: Date, to end: Date) -> Int {
        var count = 0
        var current = start

        while current <= end {
            if !isDateInWeekend(current) {
                count += 1
            }
            guard let next = date(byAdding: .day, value: 1, to: current) else { break }
            current = next
        }
        return count
    }

    func totalDaysBetween(from start: Date, to end: Date) -> Int {
        let components = dateComponents([.day], from: startOfDay(for: start), to: startOfDay(for: end))
        return (components.day ?? 0) + 1 // inclusive
    }
}
