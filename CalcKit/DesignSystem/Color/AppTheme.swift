import SwiftUI

enum AppTheme {
    static let background = Color(hex: "#454545")

    static let backgroundGradient = LinearGradient(
        colors: [background],
        startPoint: .top,
        endPoint: .bottom
    )

    static let accent = Color(hex: "#8CB6B8")

    static let operatorButton = Color(hex: "#F29A8D")
}
