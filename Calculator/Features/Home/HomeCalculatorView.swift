import SwiftUI

struct HomeCalculatorView: View {
    @Environment(HistoryStore.self) private var historyStore
    @State private var engine = CalcEngine()
    @State private var showSaveDialog = false
    var onMenu: () -> Void = {}

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            // Display
            CalcDisplay(
                expression: engine.expression,
                intermediateSteps: engine.intermediateSteps,
                displayValue: engine.displayValue
            )

            // Keypad
            CalcKeypad(
                onDigit: { engine.inputDigit($0) },
                onOperator: { engine.inputOperator($0) },
                onEquals: { engine.evaluate() },
                onClear: { engine.clear() },
                onBackspace: { engine.backspace() },
                onDecimal: { engine.inputDecimal() },
                onPercent: { engine.inputPercent() },
                onOpenParen: { engine.inputOpenParen() },
                onCloseParen: { engine.inputCloseParen() },
                onSave: { showSaveDialog = true },
                onMenu: onMenu
            )
            // 6 rows × buttonHeight + toolbar + spacing
            .frame(height: DesignTokens.CalcLayout.buttonHeight * 6
                + DesignTokens.CalcLayout.toolbarHeight
                + DesignTokens.CalcLayout.buttonSpacing * 6)
            .padding(.bottom, 8)
        }
        .saveDialog(isPresented: $showSaveDialog) { name in
            let item = HistoryItem(
                name: name,
                expression: engine.fullExpression,
                result: engine.result
            )
            historyStore.save(item: item)
        }
    }
}
