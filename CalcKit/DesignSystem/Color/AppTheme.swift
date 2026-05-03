import SwiftUI

enum AppTheme {
    static let background = Color(hex: "#353535")

    static let backgroundGradient = LinearGradient(
        colors: [background],
        startPoint: .top,
        endPoint: .bottom
    )

    static let accent = Color(hex: "#97BEC1")
    static let accentOnCard = Color(hex: "#97BEC1")

    static let operatorButton = Color(hex: "#E99689")
}
