import SwiftUI

struct RootView: View {
    @StateObject private var preferenceStorage = PreferenceStorage.shared
    
    
    var maxCalcWidth: CGFloat {
        switch preferenceStorage.selectedStyle {
        case .card, .cardAlt:
            return 400
        case .stock:
            return 250
        case .square:
            return 300
        }
    }
    var calcSizeRatio: CGFloat {
        switch preferenceStorage.selectedStyle {
        case .card, .cardAlt:
            return 0.6
        case .stock:
            return 1.45
        case .square:
            return 1
        }
    }
    
    
    var body: some View {
        GeometryReader { p in
            Form {
                let calcwidth = min(maxCalcWidth, p.size.width)
                let calcheight = calcwidth * calcSizeRatio - 10
                VStack {
                    CalculatorView(close: {})
                        .frame(height: calcheight)
                        .opacity(preferenceStorage.isEnabled ? 1 : 0.5)
                        .disabled(true)
                    Text("Preview of calculator")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color(UIColor.systemGroupedBackground))
                .padding(.top, 32)
                
                Section {
                    Toggle("Enabled", isOn: $preferenceStorage.isEnabled)
                    
                    Picker("Style", selection: $preferenceStorage.selectedStyle) {
                        Text("Card").tag(CalculatorStyle.card)
                        Text("Card Alt").tag(CalculatorStyle.cardAlt)
                        Text("Square").tag(CalculatorStyle.square)
                        Text("Stock").tag(CalculatorStyle.stock)
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("General")
                }
            }
        }
    }
}
