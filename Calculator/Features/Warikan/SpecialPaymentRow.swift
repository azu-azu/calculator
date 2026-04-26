import SwiftUI

struct SpecialPaymentRow: View {
    @Binding var payment: SpecialPayment
    let onDelete: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            // Amount
            VStack(alignment: .leading, spacing: 4) {
                Text("金額")
                    .dynamicFont(size: 12, weight: .regular)
                    .foregroundColor(DesignTokens.CommonTextColors.quaternary)
                TextField("0", value: $payment.amount, format: .number)
                    .keyboardType(.numberPad)
                    .dynamicFont(size: 16, weight: .medium)
                    .foregroundColor(DesignTokens.CommonTextColors.primary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(DesignTokens.InputColors.fieldBackground)
                    .cornerRadius(8)
            }

            // Count
            VStack(alignment: .leading, spacing: 4) {
                Text("人数")
                    .dynamicFont(size: 12, weight: .regular)
                    .foregroundColor(DesignTokens.CommonTextColors.quaternary)
                HStack {
                    Button { if payment.count > 1 { payment.count -= 1 } } label: {
                        Image(systemName: "minus.circle.fill")
                            .foregroundColor(DesignTokens.CommonTextColors.tertiary)
                    }
                    Text("\(payment.count)")
                        .dynamicFont(size: 16, weight: .medium)
                        .foregroundColor(DesignTokens.CommonTextColors.primary)
                        .frame(width: 30)
                    Button { payment.count += 1 } label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(AppTheme.accent)
                    }
                }
                .padding(.vertical, 8)
            }
            .frame(width: 100)

            // Delete
            Button(action: onDelete) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(DesignTokens.StatusColors.danger.opacity(0.7))
                    .font(.system(size: 20))
            }
        }
        .padding(12)
        .background(DesignTokens.CommonBackgroundColors.cardSubtle)
        .cornerRadius(10)
    }
}
