import SwiftUI

struct HomeCalculatorView: View {
    @Environment(HistoryStore.self) private var historyStore
    @State private var engine = CalcEngine()
    @State private var showSaveDialog = false
    var onMenu: () -> Void = {}

    var body: some View {
        GeometryReader { geo in
            let isLandscape = geo.size.width > geo.size.height

            if isLandscape {
                landscapeLayout
            } else {
                portraitLayout
            }
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

    private var portraitLayout: some View {
        VStack(spacing: 0) {
            Spacer()

            CalcDisplay(
                expression: engine.expression,
                intermediateSteps: engine.intermediateSteps,
                displayValue: engine.displayValue
            )

            keypad
                .frame(height: DesignTokens.CalcLayout.buttonHeight * 6
                    + DesignTokens.CalcLayout.toolbarHeight
                    + DesignTokens.CalcLayout.buttonSpacing * 6)
                .padding(.bottom, 8)
        }
    }

    private var landscapeLayout: some View {
        HStack(spacing: 0) {
            // Left: Display
            VStack {
                Spacer()
                CalcDisplay(
                    expression: engine.expression,
                    intermediateSteps: engine.intermediateSteps,
                    displayValue: engine.displayValue
                )
                Spacer()
            }
            .frame(maxWidth: .infinity)

            // Right: Keypad
            keypad
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
        }
    }

    private var keypad: some View {
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
            onToggleSign: { engine.toggleSign() },
            onSave: { showSaveDialog = true },
            onMenu: onMenu
        )
    }
}
