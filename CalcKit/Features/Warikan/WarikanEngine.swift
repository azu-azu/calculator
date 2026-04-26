import Foundation

struct WarikanEngine {
    static func calculate(
        totalAmount: Int,
        totalPeople: Int,
        specialPayments: [SpecialPayment]
    ) -> WarikanResult? {
        guard totalPeople > 0, totalAmount > 0 else { return nil }

        let specialTotal = specialPayments.reduce(0) { $0 + $1.amount * $1.count }
        let specialPeopleCount = specialPayments.reduce(0) { $0 + $1.count }
        let remainingAmount = totalAmount - specialTotal
        let remainingPeople = totalPeople - specialPeopleCount

        guard remainingPeople > 0 else { return nil }

        let perPerson = remainingAmount / remainingPeople
        let remainder = remainingAmount % remainingPeople

        return WarikanResult(
            perPerson: perPerson,
            remainingPeople: remainingPeople,
            remainder: remainder,
            specialPayments: specialPayments,
            totalAmount: totalAmount,
            totalPeople: totalPeople
        )
    }
}

struct WarikanResult {
    let perPerson: Int
    let remainingPeople: Int
    let remainder: Int
    let specialPayments: [SpecialPayment]
    let totalAmount: Int
    let totalPeople: Int

    var hasSpecialPayments: Bool {
        !specialPayments.isEmpty
    }

    var specialTotal: Int {
        specialPayments.reduce(0) { $0 + $1.amount * $1.count }
    }

    /// 実際に徴収される合計額（端数で入力値と異なる場合がある）
    var actualTotal: Int {
        perPerson * remainingPeople + specialTotal
    }
}
