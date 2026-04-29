import SwiftUI

struct FormulaSheetView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    formulaCard(
                        title: "展開の基本公式",
                        formula: "(x + a)(x + b) = x² + (a + b)x + ab\n\n(x + a)² = x² + 2ax + a²",
                        description: "Basic Expansion Formulas"
                    )

                    formulaCard(
                        title: "2次関数の標準形",
                        formula: "y = a(x − p)² + q",
                        description: "Vertex Form of a Quadratic Function"
                    )

                    formulaCard(
                        title: "平方完成の基本形",
                        formula: "x² + 2ax = (x + a)² − a²",
                        description: "Basic Form of Completing the Square"
                    )

                    formulaCard(
                        title: "ピタゴラスの定理",
                        formula: "a² + b² = c²",
                        description: "直角三角形の3辺の関係"
                    )

                    formulaCard(
                        title: "二次方程式の解の公式",
                        formula: "x = (-b ± √(b² - 4ac)) / 2a",
                        description: "ax² + bx + c = 0 の解"
                    )

                    formulaCard(
                        title: "円の面積",
                        formula: "S = πr²",
                        description: "半径 r の円の面積"
                    )

                    formulaCard(
                        title: "円の円周",
                        formula: "C = 2πr",
                        description: "半径 r の円の円周"
                    )

                    formulaCard(
                        title: "球の体積",
                        formula: "V = (4/3)πr³",
                        description: "半径 r の球の体積"
                    )

                    formulaCard(
                        title: "複利計算",
                        formula: "A = P(1 + r/n)^(nt)",
                        description: "P: 元金, r: 年利率, n: 複利回数/年, t: 年数"
                    )

                    formulaCard(
                        title: "三角関数の基本公式",
                        formula: "sin²θ + cos²θ = 1",
                        description: "三角関数の基本恒等式"
                    )

                    formulaCard(
                        title: "対数の性質",
                        formula: "log(ab) = log(a) + log(b)",
                        description: "対数の加法定理"
                    )
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

    private func formulaCard(title: String, formula: String, description: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .dynamicFont(size: 14, weight: .semibold)
                .foregroundColor(DesignTokens.CommonTextColors.secondary)

            Text(formula)
                .dynamicFont(size: 22, weight: .medium, design: .serif)
                .italic()
                .foregroundColor(AppTheme.accent)

            Text(description)
                .dynamicFont(size: 13, weight: .regular)
                .foregroundColor(DesignTokens.CommonTextColors.quaternary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
    }
}
