import SwiftUI

enum CalcButtonStyle {
    case number
    case function
    case operatorStyle
    case equals

    var backgroundColor: Color {
        switch self {
        case .number: Color.white.opacity(0.25)
        case .function: Color.white.opacity(0.12)
        case .operatorStyle: DesignTokens.CalcColors.operatorButton.opacity(0.55)
        case .equals: DesignTokens.CalcColors.equalsButton.opacity(0.65)
        }
    }

    var foregroundColor: Color {
        switch self {
        case .number, .function: DesignTokens.CommonTextColors.primary
        case .operatorStyle: .white
        case .equals: .white
        }
    }

    var borderColor: Color {
        switch self {
        case .number: Color.white.opacity(0.30)
        case .function: Color.white.opacity(0.22)
        case .operatorStyle: Color.white.opacity(0.25)
        case .equals: Color.white.opacity(0.30)
        }
    }

}

// MARK: - Liquid Glass Modifier

struct LiquidGlassButtonStyle: ViewModifier {
    let style: CalcButtonStyle
    let cornerRadius: CGFloat

    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    // Blur tint layer
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(.ultraThinMaterial)

                    // Color overlay
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(style.backgroundColor)
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(style.borderColor, lineWidth: 0.5)
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .shadow(color: Color.black.opacity(0.25), radius: 4, y: 2)
    }
}

struct CalcButtonView: View {
    let label: String
    let style: CalcButtonStyle
    let action: () -> Void

    init(
        _ label: String,
        style: CalcButtonStyle = .number,
        action: @escaping () -> Void
    ) {
        self.label = label
        self.style = style
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(label)
                .dynamicFont(
                    size: DesignTokens.CalcTypography.buttonSize,
                    weight: DesignTokens.CalcTypography.buttonWeight
                )
                .foregroundColor(style.foregroundColor)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .modifier(LiquidGlassButtonStyle(
                    style: style,
                    cornerRadius: DesignTokens.CalcLayout.buttonCornerRadius
                ))
        }
        .buttonStyle(.plain)
    }
}
