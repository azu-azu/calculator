import SwiftUI

struct SideMenuOverlay: View {
    @Binding var isPresented: Bool

    var body: some View {
        if isPresented {
            DesignTokens.SideMenuColors.overlay
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isPresented = false
                    }
                }
                .transition(.opacity)
        }
    }
}
