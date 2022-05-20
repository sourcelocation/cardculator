import Cephei

class TweakPreferences {
    static let shared = TweakPreferences()
    
    private let preferences = HBPreferences(identifier: "ovh.exerhythm.cardculatorPreferences")
    private(set) var enabled: ObjCBool = false
    private(set) var snapToCorners: ObjCBool = true
    private(set) var preferencesShown: ObjCBool = false
    private(set) var speed: Double = 125
    private(set) var selectedStyle: AnyObject? = "Square" as AnyObject
    
    private init() {
        preferences.register(defaults: [
            "enabled" : false,
            "snapToCorners" : true,
            "speed" : 125.0,
            "preferencesShown" : false,
            "style" : "Square",
        ])
        
        preferences.register(_Bool: &enabled, default: false, forKey: "enabled")
        preferences.register(_Bool: &snapToCorners, default: true, forKey: "snapToCorners")
        preferences.register(double: &speed, default: 125, forKey: "speed")
        preferences.register(_Bool: &preferencesShown, default: false, forKey: "preferencesShown")
        preferences.register(object: &selectedStyle, default: "Square", forKey: "style")
        
        preferences.registerPreferenceChange({ newValue, copy1 in
            NotificationCenter.default.post(name: Notification.Name("StylePrefChanged"), object: nil)
        }, forKey: "style")
    }
}
