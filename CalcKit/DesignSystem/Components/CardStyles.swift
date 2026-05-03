import SwiftUI

struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(DesignTokens.InputLayout.cardPadding)
            .background(Color(hex: "#A6A6A6"))
            .cornerRadius(DesignTokens.InputLayout.cardCornerRadius)
    }
}

extension View {
    func cardStyle() -> some View {
        modifier(CardStyle())
    }
}
