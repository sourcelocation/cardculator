

import Foundation
import SwiftUI
import Comet

final class PreferenceManager {
    private(set) var settings: Settings!
    static let shared = PreferenceManager()

    private let preferencesFilePath = "/var/mobile/Library/Preferences/net.sourceloc.cardculator.prefs.plist"

    func loadSettings() throws {
        log("loading settings")
        if let data = FileManager.default.contents(atPath: preferencesFilePath) {
            self.settings = try PropertyListDecoder().decode(Settings.self, from: data)
        } else {
            self.settings = Settings()
        }
    }
}


class Settings: Codable {
    var isEnabledTweak: Bool = true
    
    enum CalculatorStyle: String, Codable {
        case card, cardAlt, stock, square
    }
    
    var selectedStyle: CalculatorStyle = .card
    
    var squareStyleSignsFlipped = true
    
    var snapToCorners: Bool = true
    
    var speed: Double = 100.0
    
    var hapticFeedback: UIImpactFeedbackGenerator.FeedbackStyle.RawValue = 0
    
    init() {}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.isEnabledTweak = try container.decode(Bool.self, forKey: .isEnabledTweak)
        self.selectedStyle = try container.decode(Settings.CalculatorStyle.self, forKey: .selectedStyle)
        self.squareStyleSignsFlipped = try container.decodeIfPresent(Bool.self, forKey: .squareStyleSignsFlipped) ?? true
        self.snapToCorners = try container.decode(Bool.self, forKey: .snapToCorners)
        self.speed = try container.decode(Double.self, forKey: .speed)
        self.hapticFeedback = try container.decodeIfPresent(UIImpactFeedbackGenerator.FeedbackStyle.RawValue.self, forKey: .hapticFeedback) ?? 0
    }
}
