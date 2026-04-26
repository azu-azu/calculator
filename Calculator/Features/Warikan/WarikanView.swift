import SwiftUI

struct WarikanView: View {
    @State private var totalAmountText = ""
    @State private var peopleCount = 2
    @State private var specialPayments: [SpecialPayment] = []
    @State private var result: WarikanResult?

    var body: some View {
        ScrollView {
            VStack(spacing: DesignTokens.InputLayout.sectionSpacing) {
                // Title
                Text("ワリカン")
                    .dynamicFont(
                        size: DesignTokens.FeatureTypography.sectionTitleSize,
                        weight: DesignTokens.FeatureTypography.sectionTitleWeight
                    )
                    .foregroundColor(DesignTokens.CommonTextColors.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                // Input section
                VStack(spacing: DesignTokens.InputLayout.itemSpacing) {
                    // Total amount
                    VStack(alignment: .leading, spacing: 6) {
                        Text("合計金額")
                            .dynamicFont(size: 14, weight: .medium)
                            .foregroundColor(DesignTokens.CommonTextColors.secondary)
                        TextField("0", text: $totalAmountText)
                            .keyboardType(.numberPad)
                            .dynamicFont(size: 20, weight: .semibold)
                            .foregroundColor(DesignTokens.CommonTextColors.primary)
                            .padding(DesignTokens.InputLayout.fieldPadding)
                            .background(DesignTokens.InputColors.fieldBackground)
                            .cornerRadius(DesignTokens.InputLayout.fieldCornerRadius)
                    }

                    // People count
                    VStack(alignment: .leading, spacing: 6) {
                        Text("人数")
                            .dynamicFont(size: 14, weight: .medium)
                            .foregroundColor(DesignTokens.CommonTextColors.secondary)
                        HStack {
                            Button {
                                if peopleCount > 1 { peopleCount -= 1 }
                            } label: {
                                Image(systemName: "minus.circle.fill")
                                    .font(.system(size: 28))
                                    .foregroundColor(DesignTokens.CommonTextColors.tertiary)
                            }

                            Text("\(peopleCount)")
                                .dynamicFont(size: 24, weight: .semibold, design: .monospaced)
                                .foregroundColor(DesignTokens.CommonTextColors.primary)
                                .frame(width: 60)

                            Button {
                                peopleCount += 1
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 28))
                                    .foregroundColor(AppTheme.accent)
                            }

                            Text("人")
                                .dynamicFont(size: 16, weight: .regular)
                                .foregroundColor(DesignTokens.CommonTextColors.tertiary)

                            Spacer()
                        }
                    }
                }
                .cardStyle()

                // Calculate button
                Button {
                    calculate()
                } label: {
                    Text("ワリカン")
                        .dynamicFont(size: 17, weight: .semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(AppTheme.accent)
                        .cornerRadius(12)
                }
                .buttonStyle(.plain)

                // Special payments
                VStack(spacing: 12) {
                    ForEach(specialPayments.indices, id: \.self) { index in
                        SpecialPaymentRow(
                            payment: $specialPayments[index],
                            onDelete: { specialPayments.remove(at: index) }
                        )
                    }

                    Button {
                        specialPayments.append(SpecialPayment())
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "plus.circle.fill")
                            Text("特殊払い追加")
                                .dynamicFont(size: 15, weight: .medium)
                        }
                        .foregroundColor(AppTheme.accent)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(AppTheme.accent.opacity(0.1))
                        .cornerRadius(10)
                    }
                    .buttonStyle(.plain)
                }

                // Result
                if let result {
                    resultCard(result)
                }

                Spacer(minLength: 40)
            }
            .padding(.horizontal, DesignTokens.InputLayout.screenHorizontal)
            .padding(.top, 60)
        }
    }

    private func calculate() {
        let total = Int(totalAmountText) ?? 0
        result = WarikanEngine.calculate(
            totalAmount: total,
            totalPeople: peopleCount,
            specialPayments: specialPayments
        )
    }

    private func resultCard(_ result: WarikanResult) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("結果")
                .dynamicFont(size: 16, weight: .semibold)
                .foregroundColor(DesignTokens.CommonTextColors.secondary)

            if result.hasSpecialPayments {
                ForEach(result.specialPayments) { sp in
                    HStack {
                        Text("特殊払い")
                            .dynamicFont(size: 14, weight: .regular)
                            .foregroundColor(DesignTokens.CommonTextColors.tertiary)
                        Spacer()
                        Text("¥\(sp.amount.formatted()) × \(sp.count)人")
                            .dynamicFont(size: 14, weight: .medium, design: .monospaced)
                            .foregroundColor(DesignTokens.CommonTextColors.secondary)
                    }
                }

                Divider()
                    .background(DesignTokens.CommonBackgroundColors.cardBorderSubtle)
            }

            HStack {
                Text("ワリカン")
                    .dynamicFont(size: 16, weight: .medium)
                    .foregroundColor(DesignTokens.CommonTextColors.primary)
                Spacer()
                VStack(alignment: .trailing, spacing: 4) {
                    Text("¥\(result.perPerson.formatted()) × \(result.remainingPeople)人")
                        .dynamicFont(size: 20, weight: .bold, design: .monospaced)
                        .foregroundColor(AppTheme.accent)
                    if result.remainder > 0 {
                        Text("端数: ¥\(result.remainder.formatted())")
                            .dynamicFont(size: 12, weight: .regular)
                            .foregroundColor(DesignTokens.CommonTextColors.quaternary)
                    }
                }
            }
        }
        .cardStyle()
    }
}
