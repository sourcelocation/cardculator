import Foundation
import Comet

// MARK: - Internal

final class PreferenceStorage: ObservableObject {
    
    static var shared = PreferenceStorage()
    
    private static let registry: String = "/var/mobile/Library/Preferences/net.sourceloc.cardculator.prefs.plist"
    /// Welcome to Comet
    /// By @ginsudev
    ///
    /// Mark your preferences with `@Published(key: "someKey", registry: PreferenceStorage.registry)`.
    /// When the value of these properties are changed, they are also saved into the preferences file on disk to persist changes.
    ///
    /// The initial value you initialise your property with is the fallback / default value that will be used if there is no present value for the
    /// given key.
    ///
    /// `@Published(key: _ registry:_)` properties can only store Foundational types that conform
    /// to `Codable` (i.e. `String, Data, Int, Bool, Double, Float`, etc).

    // Preferences
    @Published(key: "isEnabledTweak", registry: registry) var isEnabled = true
    @Published(key: "selectedStyle", registry: registry) var selectedStyle = CalculatorStyle.card
    @Published(key: "snapToCorners", registry: registry) var snapToCorners = true
    @Published(key: "speed", registry: registry) var speed = 100.0
}



enum CalculatorStyle: Codable {
    case card, cardAlt, stock, square
}
