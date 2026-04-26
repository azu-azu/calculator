import SwiftUI

struct GoalCalcView: View {
    @State private var targetText = ""
    @State private var selectedPeriod: Period = .year
    @State private var isPlus = true

    enum Period: String, CaseIterable, Identifiable {
        case day = "日"
        case week = "週"
        case month = "月"
        case year = "年"

        var id: String { rawValue }

        var daysMultiplier: Double {
            switch self {
            case .day: 1
            case .week: 7
            case .month: 30.44
            case .year: 365
            }
        }
    }

    private var targetValue: Double {
        Double(targetText) ?? 0
    }

    private var dailyRate: Double {
        guard selectedPeriod.daysMultiplier > 0 else { return 0 }
        let rate = targetValue / selectedPeriod.daysMultiplier
        return isPlus ? rate : -rate
    }

    var body: some View {
        ScrollView {
            VStack(spacing: DesignTokens.InputLayout.sectionSpacing) {
                // Title
                Text("目標計算")
                    .dynamicFont(
                        size: DesignTokens.FeatureTypography.sectionTitleSize,
                        weight: DesignTokens.FeatureTypography.sectionTitleWeight
                    )
                    .foregroundColor(DesignTokens.CommonTextColors.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                // Input section
                VStack(spacing: DesignTokens.InputLayout.itemSpacing) {
                    // Period & direction
                    HStack(spacing: 12) {
                        // Period count (always 1)
                        Text("1")
                            .dynamicFont(size: 24, weight: .bold, design: .monospaced)
                            .foregroundColor(DesignTokens.CommonTextColors.primary)

                        // Period picker
                        Picker("", selection: $selectedPeriod) {
                            ForEach(Period.allCases) { period in
                                Text(period.rawValue).tag(period)
                            }
                        }
                        .pickerStyle(.segmented)

                        Text("で")
                            .dynamicFont(size: 16, weight: .regular)
                            .foregroundColor(DesignTokens.CommonTextColors.tertiary)

                        // Plus/Minus toggle
                        Picker("", selection: $isPlus) {
                            Text("+").tag(true)
                            Text("-").tag(false)
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 80)
                    }

                    // Target number
                    TextField("目標数値", text: $targetText)
                        .keyboardType(.decimalPad)
                        .dynamicFont(size: 24, weight: .semibold)
                        .foregroundColor(DesignTokens.CommonTextColors.primary)
                        .padding(DesignTokens.InputLayout.fieldPadding)
                        .background(DesignTokens.InputColors.fieldBackground)
                        .cornerRadius(DesignTokens.InputLayout.fieldCornerRadius)
                }
                .cardStyle()

                // Results
                if targetValue > 0 {
                    VStack(spacing: 12) {
                        resultRow(label: "1日", value: dailyRate)
                        Divider().background(DesignTokens.CommonBackgroundColors.cardBorderSubtle)
                        resultRow(label: "1週間", value: dailyRate * 7)
                        Divider().background(DesignTokens.CommonBackgroundColors.cardBorderSubtle)
                        resultRow(label: "1ヶ月", value: dailyRate * 30.44)
                        Divider().background(DesignTokens.CommonBackgroundColors.cardBorderSubtle)
                        resultRow(label: "1年", value: dailyRate * 365)
                    }
                    .cardStyle()
                }

                Spacer(minLength: 40)
            }
            .padding(.horizontal, DesignTokens.InputLayout.screenHorizontal)
            .padding(.top, 60)
        }
    }

    private func resultRow(label: String, value: Double) -> some View {
        HStack {
            Text(label)
                .dynamicFont(size: 16, weight: .regular)
                .foregroundColor(DesignTokens.CommonTextColors.secondary)
            Spacer()
            Text(formatValue(value))
                .dynamicFont(size: 20, weight: .semibold, design: .monospaced)
                .foregroundColor(AppTheme.accent)
        }
    }

    private func formatValue(_ value: Double) -> String {
        let prefix = value >= 0 ? "+" : ""
        if value == value.rounded() {
            return "\(prefix)\(Int(value))"
        }
        return "\(prefix)\(String(format: "%.2f", value))"
    }
}
