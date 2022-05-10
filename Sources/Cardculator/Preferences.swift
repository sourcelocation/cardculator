import Cephei

class Preferences {
    static let shared = Preferences()
    
    private let preferences = HBPreferences(identifier: "ovh.exerhythm.cardculatorPreferences")
    private(set) var enabled: ObjCBool = true
    private(set) var snapToCorners: ObjCBool = true
    private(set) var speed: Double = 100
    
    private init() {
        preferences.register(defaults: [
            "enabled" : true,
            "snapToCorners" : true,
            "speed" : 125.0,
        ])
    
        preferences.register(_Bool: &enabled, default: true, forKey: "enabled")
        preferences.register(_Bool: &snapToCorners, default: true, forKey: "snapToCorners")
        preferences.register(double: &speed, default: 125, forKey: "speed")
    }
}
