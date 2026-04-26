import SwiftUI

struct CalcKeypad: View {
    let onDigit: (String) -> Void
    let onOperator: (CalcEngine.Operator) -> Void
    let onEquals: () -> Void
    let onClear: () -> Void
    let onBackspace: () -> Void
    let onDecimal: () -> Void
    let onPercent: () -> Void
    let onOpenParen: () -> Void
    let onCloseParen: () -> Void
    let onSave: () -> Void
    let onMenu: () -> Void

    private let spacing = DesignTokens.CalcLayout.buttonSpacing

    var body: some View {
        GeometryReader { geo in
            let totalWidth = geo.size.width - 24
            let buttonWidth = (totalWidth - spacing * 3) / 4

            VStack(spacing: spacing) {
                // Row 1: (, ), ← (wide)
                HStack(spacing: spacing) {
                    CalcButtonView("(", style: .function) { onOpenParen() }
                    CalcButtonView(")", style: .function) { onCloseParen() }
                    Button { onBackspace() } label: {
                        Text("←")
                            .dynamicFont(
                                size: DesignTokens.CalcTypography.buttonSize,
                                weight: DesignTokens.CalcTypography.buttonWeight
                            )
                            .foregroundColor(DesignTokens.CommonTextColors.primary)
                            .frame(width: buttonWidth * 2 + spacing, height: DesignTokens.CalcLayout.buttonHeight)
                            .background(DesignTokens.CalcColors.functionButton)
                            .cornerRadius(DesignTokens.CalcLayout.buttonCornerRadius)
                    }
                    .buttonStyle(.plain)
                }

                // Row 2: 7, 8, 9, ÷
                HStack(spacing: spacing) {
                    CalcButtonView("7") { onDigit("7") }
                    CalcButtonView("8") { onDigit("8") }
                    CalcButtonView("9") { onDigit("9") }
                    CalcButtonView("÷", style: .operatorStyle) { onOperator(.divide) }
                }

                // Row 3: 4, 5, 6, ×
                HStack(spacing: spacing) {
                    CalcButtonView("4") { onDigit("4") }
                    CalcButtonView("5") { onDigit("5") }
                    CalcButtonView("6") { onDigit("6") }
                    CalcButtonView("×", style: .operatorStyle) { onOperator(.multiply) }
                }

                // Row 4: 1, 2, 3, -
                HStack(spacing: spacing) {
                    CalcButtonView("1") { onDigit("1") }
                    CalcButtonView("2") { onDigit("2") }
                    CalcButtonView("3") { onDigit("3") }
                    CalcButtonView("-", style: .operatorStyle) { onOperator(.subtract) }
                }

                // Row 5: 0 (wide), ., +
                HStack(spacing: spacing) {
                    Button { onDigit("0") } label: {
                        Text("0")
                            .dynamicFont(
                                size: DesignTokens.CalcTypography.buttonSize,
                                weight: DesignTokens.CalcTypography.buttonWeight
                            )
                            .foregroundColor(DesignTokens.CommonTextColors.primary)
                            .frame(width: buttonWidth * 2 + spacing, height: DesignTokens.CalcLayout.buttonHeight)
                            .background(DesignTokens.CalcColors.numberButton)
                            .cornerRadius(DesignTokens.CalcLayout.buttonCornerRadius)
                    }
                    .buttonStyle(.plain)

                    CalcButtonView(".") { onDecimal() }
                    CalcButtonView("+", style: .operatorStyle) { onOperator(.add) }
                }

                // Row 6: AC, %, =
                HStack(spacing: spacing) {
                    CalcButtonView("AC", style: .function) { onClear() }
                    CalcButtonView("%", style: .function) { onPercent() }
                    Button { onEquals() } label: {
                        Text("=")
                            .dynamicFont(
                                size: DesignTokens.CalcTypography.buttonSize,
                                weight: DesignTokens.CalcTypography.buttonWeight
                            )
                            .foregroundColor(.white)
                            .frame(width: buttonWidth * 2 + spacing, height: DesignTokens.CalcLayout.buttonHeight)
                            .background(DesignTokens.CalcColors.equalsButton)
                            .cornerRadius(DesignTokens.CalcLayout.buttonCornerRadius)
                    }
                    .buttonStyle(.plain)
                }

                // Toolbar: ☰ (左) ... Save (右)
                HStack {
                    Button(action: onMenu) {
                        Image(systemName: "line.3.horizontal")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(DesignTokens.CommonTextColors.secondary)
                            .frame(width: 48, height: DesignTokens.CalcLayout.toolbarHeight)
                            .background(DesignTokens.CalcColors.functionButton)
                            .cornerRadius(10)
                    }
                    .buttonStyle(.plain)

                    Spacer()

                    Button(action: onSave) {
                        HStack(spacing: 6) {
                            Image(systemName: "square.and.arrow.down")
                                .font(.system(size: 14))
                            Text("Save")
                                .dynamicFont(size: 14, weight: .medium)
                        }
                        .foregroundColor(AppTheme.accent)
                        .padding(.horizontal, 16)
                        .frame(height: DesignTokens.CalcLayout.toolbarHeight)
                        .background(AppTheme.accent.opacity(0.12))
                        .cornerRadius(10)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 12)
        }
    }
}
