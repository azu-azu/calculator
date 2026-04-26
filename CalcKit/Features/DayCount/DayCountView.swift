import SwiftUI

struct DayCountView: View {
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var businessDaysOnly = false

    private var dayCount: Int {
        let calendar = Calendar.current
        if businessDaysOnly {
            return calendar.businessDaysBetween(from: startDate, to: endDate)
        }
        return calendar.totalDaysBetween(from: startDate, to: endDate)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: DesignTokens.InputLayout.sectionSpacing) {
                // Title
                Text("日数計算")
                    .dynamicFont(
                        size: DesignTokens.FeatureTypography.sectionTitleSize,
                        weight: DesignTokens.FeatureTypography.sectionTitleWeight
                    )
                    .foregroundColor(DesignTokens.CommonTextColors.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                // Date pickers
                VStack(spacing: DesignTokens.InputLayout.itemSpacing) {
                    HStack {
                        Text("スタート日")
                            .dynamicFont(size: 14, weight: .medium)
                            .foregroundColor(DesignTokens.CommonTextColors.secondary)
                        Spacer()
                        DatePicker("", selection: $startDate, displayedComponents: .date)
                            .labelsHidden()
                            .tint(AppTheme.accent)
                    }

                    Divider().background(DesignTokens.CommonBackgroundColors.cardBorderSubtle)

                    HStack {
                        Text("エンド日")
                            .dynamicFont(size: 14, weight: .medium)
                            .foregroundColor(DesignTokens.CommonTextColors.secondary)
                        Spacer()
                        DatePicker("", selection: $endDate, displayedComponents: .date)
                            .labelsHidden()
                            .tint(AppTheme.accent)
                    }
                }
                .cardStyle()

                // Toggle
                HStack {
                    Text("平日のみ")
                        .dynamicFont(size: 16, weight: .regular)
                        .foregroundColor(DesignTokens.CommonTextColors.primary)
                    Spacer()
                    Toggle("", isOn: $businessDaysOnly)
                        .tint(AppTheme.accent)
                }
                .cardStyle()

                // Result
                VStack(spacing: 8) {
                    Text("\(dayCount)")
                        .dynamicFont(
                            size: DesignTokens.FeatureTypography.resultSize,
                            weight: DesignTokens.FeatureTypography.resultWeight,
                            design: .monospaced
                        )
                        .foregroundColor(AppTheme.accent)
                    Text(businessDaysOnly ? "平日" : "日間")
                        .dynamicFont(size: 16, weight: .regular)
                        .foregroundColor(DesignTokens.CommonTextColors.tertiary)
                }
                .frame(maxWidth: .infinity)
                .cardStyle()

                Spacer(minLength: 40)
            }
            .padding(.horizontal, DesignTokens.InputLayout.screenHorizontal)
            .padding(.top, 16)
        }
    }
}
