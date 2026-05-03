import SwiftUI

enum CalcButtonStyle {
    case number
    case function
    case operatorStyle
    case equals

    var backgroundColor: Color {
        switch self {
        case .number: Color(hex: "#A8A8A8")
        case .function: Color(hex: "#7A7A7A")
        case .operatorStyle: DesignTokens.CalcColors.operatorButton
        case .equals: DesignTokens.CalcColors.equalsButton
        }
    }

    var foregroundColor: Color {
        Color(hex: "#111111")
    }

}

// MARK: - Raised Button Modifier

struct RaisedButtonStyle: ViewModifier {
    let style: CalcButtonStyle
    let cornerRadius: CGFloat

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(style.backgroundColor)
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .padding(EdgeInsets(top: 2, leading: 2, bottom: 4, trailing: 2))
            .background(
                RoundedRectangle(cornerRadius: cornerRadius + 2)
                    .fill(Color.black)
            )
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
                .modifier(RaisedButtonStyle(
                    style: style,
                    cornerRadius: DesignTokens.CalcLayout.buttonCornerRadius
                ))
        }
        .buttonStyle(.plain)
    }
}
