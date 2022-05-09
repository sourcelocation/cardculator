import Cephei

class Preferences {
    static let shared = Preferences()
    
    private let preferences = HBPreferences(identifier: "ovh.exerhythm.cardculator")
    private(set) var enabled: ObjCBool = true
    
    private init() {
        preferences.register(defaults: [
            "enabled" : true,
        ])
    
        preferences.register(_Bool: &enabled, default: true, forKey: "enabled")
    }
}
