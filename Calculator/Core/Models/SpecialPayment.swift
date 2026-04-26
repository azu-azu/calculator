import Foundation

struct SpecialPayment: Identifiable {
    let id = UUID()
    var amount: Int = 0
    var count: Int = 1
}
