import SwiftUI

struct CalcDisplay: View {
    let expression: String
    let intermediateSteps: [String]
    let displayValue: String

    var body: some View {
        VStack(alignment: .trailing, spacing: 6) {
            // Expression (small, gray, top)
            if !expression.isEmpty {
                Text(expression)
                    .dynamicFont(
                        size: DesignTokens.CalcTypography.expressionSize,
                        weight: DesignTokens.CalcTypography.expressionWeight
                    )
                    .foregroundColor(DesignTokens.CalcColors.expressionText)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
            }

            // Intermediate steps (accent, middle)
            ForEach(Array(intermediateSteps.enumerated()), id: \.offset) { _, step in
                Text(step)
                    .dynamicFont(
                        size: DesignTokens.CalcTypography.expressionSize - 2,
                        weight: DesignTokens.CalcTypography.expressionWeight
                    )
                    .foregroundColor(AppTheme.accent.opacity(0.7))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }

            // Display value (large, white, always at bottom)
            Text(displayValue)
                .dynamicFont(
                    size: DesignTokens.CalcTypography.displaySize,
                    weight: DesignTokens.CalcTypography.displayWeight,
                    design: .monospaced
                )
                .foregroundColor(DesignTokens.CalcColors.displayText)
                .lineLimit(1)
                .minimumScaleFactor(0.3)
                .monospacedDigit()
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.horizontal, DesignTokens.CalcLayout.displayHorizontalPadding)
        .padding(.bottom, DesignTokens.CalcLayout.displayBottomPadding)
    }
}
