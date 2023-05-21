import SwiftUI

struct RootView: View {
    @StateObject private var preferenceStorage = PreferenceStorage.shared
    
    var body: some View {
        Form {
            Section {
                Toggle("Enabled", isOn: $preferenceStorage.isEnabled)
                
                Text("Style:")
                Picker("Style", selection: $preferenceStorage.selectedStyle) {
                    Text("Card").tag("card")
                    Text("Card Alt").tag("cardAlt")
                    Text("Square").tag("square")
                    Text("Stock").tag("stock")
                }
                .pickerStyle(.segmented)
                
                if preferenceStorage.selectedStyle == "square" {
                    Toggle("Divide and Equal buttons swapped", isOn: $preferenceStorage.squareStyleSignsFlipped)
                }
            } header: {
                Text("General")
            } footer: {
                Text("To add the Cardculator Control Center module, go to Settings -> Control Center and add Cardculator from there.")
            }
            
            Section {
                Toggle("Snap to corners", isOn: $preferenceStorage.snapToCorners)
                Text("Speed:")
                HStack {
                    Slider(value: $preferenceStorage.speed, in: 50...250)
                    Text("\(Int(preferenceStorage.speed))%")
                        .frame(width: 40)
                }
            } header: {
                Text("Behavior")
            }
            
            Section {
                Picker("hapticFeedback", selection: $preferenceStorage.hapticFeedback) {
                    Text("Off").tag(-1)
                    Text("Light").tag(UIImpactFeedbackGenerator.FeedbackStyle.light.rawValue)
                    Text("Medium").tag(UIImpactFeedbackGenerator.FeedbackStyle.medium.rawValue)
                    Text("Heavy").tag(UIImpactFeedbackGenerator.FeedbackStyle.heavy.rawValue)
                }
                .pickerStyle(.segmented)
                .onChange(of: preferenceStorage.hapticFeedback) { newValue in
                    guard let style = UIImpactFeedbackGenerator.FeedbackStyle(rawValue: newValue), style.rawValue != -1 else { return }
                    UIImpactFeedbackGenerator(style: style).impactOccurred()
                }
            } header: {
                Text("Haptic Feedback (Vibration)")
            }
        }
        .accentColor(.orange)
        .toggleStyle(SwitchToggleStyle(tint: .orange))
    }
}
