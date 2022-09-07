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
        
        preferences.register(&enabled, default: false, forKey: "enabled")
        preferences.register(&snapToCorners, default: true, forKey: "snapToCorners")
        preferences.register(&speed, default: 125, forKey: "speed")
        preferences.register(&preferencesShown, default: false, forKey: "preferencesShown")
        preferences.register(&selectedStyle, default: "Square", forKey: "style")
        
        preferences.registerPreferenceChange({ newValue, copy1 in
            NotificationCenter.default.post(name: Notification.Name("StylePrefChanged"), object: nil)
        }, forKey: "style")
    }
}
