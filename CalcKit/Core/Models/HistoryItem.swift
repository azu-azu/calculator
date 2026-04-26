import Foundation

struct HistoryItem: Identifiable, Codable {
    let id: UUID
    let name: String
    let expression: String
    let result: String
    let createdAt: Date

    init(name: String, expression: String, result: String) {
        self.id = UUID()
        self.name = name
        self.expression = expression
        self.result = result
        self.createdAt = Date()
    }
}
