import SwiftUI

struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(DesignTokens.InputLayout.cardPadding)
            .background(DesignTokens.CommonBackgroundColors.card)
            .cornerRadius(DesignTokens.InputLayout.cardCornerRadius)
    }
}

struct InteractiveCardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(DesignTokens.InputLayout.cardPadding)
            .background(DesignTokens.CommonBackgroundColors.cardHighlight)
            .cornerRadius(DesignTokens.InputLayout.cardCornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: DesignTokens.InputLayout.cardCornerRadius)
                    .stroke(DesignTokens.CommonBackgroundColors.cardBorderSubtle, lineWidth: 1)
            )
    }
}

extension View {
    func cardStyle() -> some View {
        modifier(CardStyle())
    }

    func interactiveCardStyle() -> some View {
        modifier(InteractiveCardStyle())
    }
}
