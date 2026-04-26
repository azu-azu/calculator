import Foundation

struct SpecialPayment: Identifiable, Equatable {
    let id = UUID()
    var amountText: String = ""
    var count: Int = 1

    var amount: Int {
        get { Int(amountText) ?? 0 }
        set { amountText = newValue == 0 ? "" : String(newValue) }
    }
}
