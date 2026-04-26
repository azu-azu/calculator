import SwiftUI

@main
struct CalculatorApp: App {
    @State private var historyStore = HistoryStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(historyStore)
        }
    }
}
