import SwiftUI

struct DynamicFont: ViewModifier {
    let size: CGFloat
    let weight: Font.Weight
    let design: Font.Design

    init(size: CGFloat, weight: Font.Weight = .regular, design: Font.Design = .rounded) {
        self.size = size
        self.weight = weight
        self.design = design
    }

    func body(content: Content) -> some View {
        content.font(.system(size: size, weight: weight, design: design))
    }
}

extension View {
    func dynamicFont(
        size: CGFloat,
        weight: Font.Weight = .regular,
        design: Font.Design = .rounded
    ) -> some View {
        modifier(DynamicFont(size: size, weight: weight, design: design))
    }
}
