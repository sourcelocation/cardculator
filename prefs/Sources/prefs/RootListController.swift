import SwiftUI
import Comet
import prefsC

class RootListController: CMViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup(content: RootView())
        self.title = "Cardculator"
    }
}
