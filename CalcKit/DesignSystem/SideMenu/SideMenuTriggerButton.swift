import SwiftUI

struct SideMenuTriggerButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "line.3.horizontal")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white)
                .frame(width: 44, height: 44)
                .background(Color(hex: "#2A2A2A"))
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel("メニューを開く")
    }
}
