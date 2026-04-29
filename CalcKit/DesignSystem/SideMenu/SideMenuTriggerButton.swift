import SwiftUI

struct SideMenuTriggerButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "line.3.horizontal")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(DesignTokens.CommonTextColors.secondary)
                .frame(width: 44, height: 44)
                .background(DesignTokens.CommonBackgroundColors.cardHighlight)
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel("メニューを開く")
    }
}
