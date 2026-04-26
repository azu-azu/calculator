import SwiftUI

struct SaveDialog: ViewModifier {
    @Binding var isPresented: Bool
    @State private var name = ""
    let onSave: (String) -> Void

    func body(content: Content) -> some View {
        content
            .alert("計算を保存", isPresented: $isPresented) {
                TextField("名前を入力", text: $name)
                Button("保存") {
                    let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
                    onSave(trimmed.isEmpty ? "名称なし" : trimmed)
                    name = ""
                }
                Button("キャンセル", role: .cancel) {
                    name = ""
                }
            } message: {
                Text("計算結果に名前をつけて保存します")
            }
    }
}

extension View {
    func saveDialog(isPresented: Binding<Bool>, onSave: @escaping (String) -> Void) -> some View {
        modifier(SaveDialog(isPresented: isPresented, onSave: onSave))
    }
}
