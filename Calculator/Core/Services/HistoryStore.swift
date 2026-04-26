import Foundation
import Observation

@Observable
class HistoryStore {
    private static let storageKey = "calculator_history"

    var items: [HistoryItem] = []

    init() {
        load()
    }

    func save(item: HistoryItem) {
        items.insert(item, at: 0)
        persist()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        persist()
    }

    func deleteItem(_ item: HistoryItem) {
        items.removeAll { $0.id == item.id }
        persist()
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: Self.storageKey),
              let decoded = try? JSONDecoder().decode([HistoryItem].self, from: data) else {
            return
        }
        items = decoded
    }

    private func persist() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        UserDefaults.standard.set(data, forKey: Self.storageKey)
    }
}
