import Foundation
import Comet
import Combine

// MARK: - Internal

final class PreferenceStorage: ObservableObject {
    
    static var shared = PreferenceStorage()
    
    private static let registry: String = "/var/mobile/Library/Preferences/net.sourceloc.cardculator.prefs.plist"
    
    @Published(key: "isEnabledTweak", registry: registry) var isEnabled = true
    @Published(key: "selectedStyle", registry: registry) var selectedStyle = "card"
    @Published(key: "snapToCorners", registry: registry) var snapToCorners = true
    @Published(key: "speed", registry: registry) var speed = 100.0
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        self.objectWillChange
            .sink { _ in
                let center = CFNotificationCenterGetDarwinNotifyCenter()
                let name = "net.sourceloc.cardculator.prefs/Update" as CFString
                let object = UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque())
                CFNotificationCenterPostNotification(center, .init(name), object, nil, true)
            }
            .store(in: &cancellables)
    }
}
