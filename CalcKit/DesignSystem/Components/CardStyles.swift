import SwiftUI

struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(DesignTokens.InputLayout.cardPadding)
            .background(DesignTokens.CommonBackgroundColors.card)
            .cornerRadius(DesignTokens.InputLayout.cardCornerRadius)
    }
}

extension View {
    func cardStyle() -> some View {
        modifier(CardStyle())
    }
}
