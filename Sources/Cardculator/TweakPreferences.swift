

import Foundation
import SwiftUI
import Comet

final class PreferenceManager {
    private(set) var settings: Settings!
    static let shared = PreferenceManager()

    private let preferencesFilePath = "/var/mobile/Library/Preferences/net.sourceloc.cardculator.prefs.plist"

    func loadSettings() throws {
        remLog("loading settings")
        if let data = FileManager.default.contents(atPath: preferencesFilePath) {
            self.settings = try PropertyListDecoder().decode(Settings.self, from: data)
        } else {
            self.settings = Settings()
        }
    }
}


struct Settings: Codable {
    var isEnabledTweak: Bool = true
    
    enum CalculatorStyle: Codable {
        case card, cardAlt, stock, square
    }
    
    var selectedStyle: CalculatorStyle = .card
    
    var snapToCorners: Bool = true
    
    var speed: Double = 100.0
}
