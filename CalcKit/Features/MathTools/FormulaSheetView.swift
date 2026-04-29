import SwiftUI

private struct FormulaItem: Identifiable {
    var id: String { title }
    let title: String
    let formula: String
    let description: String
}

private let formulas: [FormulaItem] = [
    FormulaItem(
        title: "展開の基本公式",
        formula: "(x + a)(x + b) = x² + (a + b)x + ab\n\n(ax + b)(cx + d) = acx² + (ad + bc)x + bd",
        description: "かけ算をばらして、各項に展開して見る"
    ),
    FormulaItem(
        title: "特殊な展開（2乗と和と差の積）",
        formula: "(x + a)² = x² + 2ax + a²\n\n(x + a)(x − a) = x² − a²",
        description: "同じ形が並ぶとき、展開をショートカットして見る"
    ),
    FormulaItem(
        title: "2次関数の標準形",
        formula: "y = a(x − p)² + q",
        description: "グラフの頂点が (p, q) だと見る"
    ),
    FormulaItem(
        title: "平方完成の基本形",
        formula: "x² + 2ax = (x + a)² − a²",
        description: "2次式を、2乗の形に作り替えて見る"
    ),
    FormulaItem(
        title: "ピタゴラスの定理",
        formula: "a² + b² = c²",
        description: "直角三角形の3辺の関係"
    ),
    FormulaItem(
        title: "二次方程式の解の公式",
        formula: "x = (-b ± √(b² - 4ac)) / 2a",
        description: "ax² + bx + c = 0（a ≠ 0）の解"
    ),
    FormulaItem(
        title: "円の面積",
        formula: "S = πr²",
        description: "半径 r の円の面積"
    ),
    FormulaItem(
        title: "円の円周",
        formula: "C = 2πr",
        description: "半径 r の円の円周"
    ),
    FormulaItem(
        title: "球の体積",
        formula: "V = (4/3)πr³",
        description: "半径 r の球の体積"
    ),
    FormulaItem(
        title: "複利計算",
        formula: "A = P(1 + r/n)^(nt)",
        description: "P: 元金, r: 年利率（5%なら0.05）, n: 複利回数/年, t: 年数"
    ),
    FormulaItem(
        title: "三角関数の基本公式",
        formula: "sin²θ + cos²θ = 1",
        description: "三角関数の基本恒等式"
    ),
    FormulaItem(
        title: "対数の性質",
        formula: "log(ab) = log(a) + log(b)",
        description: "かけ算を、対数では足し算として扱う性質（a, b > 0）"
    ),
]

struct FormulaSheetView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(formulas) { item in
                        formulaCard(item)
                    }
                }
                .padding(.horizontal, DesignTokens.InputLayout.screenHorizontal)
                .padding(.bottom, 40)
            }
            .background(AppTheme.backgroundGradient.ignoresSafeArea())
            .navigationTitle("数式")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("閉じる") {
                        dismiss()
                    }
                    .foregroundColor(AppTheme.accent)
                }
            }
        }
    }

    private func formulaCard(_ item: FormulaItem) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(item.title)
                .dynamicFont(size: 14, weight: .semibold)
                .foregroundColor(DesignTokens.CommonTextColors.secondary)

            Text(item.formula)
                .dynamicFont(size: 22, weight: .medium, design: .serif)
                .italic()
                .multilineTextAlignment(.leading)
                .lineSpacing(4)
                .minimumScaleFactor(0.75)
                .foregroundColor(AppTheme.accent)

            Text(item.description)
                .dynamicFont(size: 13, weight: .regular)
                .foregroundColor(DesignTokens.CommonTextColors.quaternary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
    }
}
