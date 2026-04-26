import SwiftUI

enum CalcButtonStyle {
    case number
    case function
    case operatorStyle
    case equals

    var backgroundColor: Color {
        switch self {
        case .number: DesignTokens.CalcColors.numberButton
        case .function: DesignTokens.CalcColors.functionButton
        case .operatorStyle: DesignTokens.CalcColors.operatorButton
        case .equals: DesignTokens.CalcColors.equalsButton
        }
    }

    var foregroundColor: Color {
        switch self {
        case .number, .function: DesignTokens.CommonTextColors.primary
        case .operatorStyle: .white
        case .equals: .white
        }
    }
}

struct CalcButtonView: View {
    let label: String
    let style: CalcButtonStyle
    let isWide: Bool
    let action: () -> Void

    init(
        _ label: String,
        style: CalcButtonStyle = .number,
        isWide: Bool = false,
        action: @escaping () -> Void
    ) {
        self.label = label
        self.style = style
        self.isWide = isWide
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
                .frame(maxWidth: .infinity)
                .frame(height: DesignTokens.CalcLayout.buttonHeight)
                .background(style.backgroundColor)
                .cornerRadius(DesignTokens.CalcLayout.buttonCornerRadius)
        }
        .buttonStyle(.plain)
    }
}
