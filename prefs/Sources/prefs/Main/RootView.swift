import SwiftUI

struct RootView: View {
    @StateObject private var preferenceStorage = PreferenceStorage.shared
    
    
    var body: some View {
        GeometryReader { p in
            Form {
                Section {
                    Toggle("Enabled", isOn: $preferenceStorage.isEnabled)
                        .disabled(true)
                    
                    Picker("Style", selection: $preferenceStorage.selectedStyle) {
                        Text("Card").tag("card")
                        Text("Card Alt").tag("cardAlt")
                        Text("Square").tag("square")
                        Text("Stock").tag("stock")
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("General")
                }
            }
        }
//        .onChange(of: preferenceStorage) { newValue in
//            remLog("ReloadSettings 1")
//            NotificationCenter.default.post(name: NSNotification.Name("ReloadSettings"), object: nil)
//        }
    }
}
