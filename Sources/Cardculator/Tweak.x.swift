import Orion
import CardculatorC
import SwiftUI
import os

var calculatorWindow: CalculatorWindow!
var listener: CardculatorListener?



class CardculatorListener: NSObject, LAListener {
    let listenerId = "ovh.exerhythm.cardculator"
    
    func activator(_ activator: LAActivator?, receive event: LAEvent?) {
        guard TweakPreferences.shared.enabled.boolValue else { return }
        event?.isHandled = true
        presentCalculator()
    }
    
    @objc func presentCalculator() {
        if calculatorWindow.vc.calculatorViewShown() {
            calculatorWindow.vc.hideCalculatorView()
        } else {
            calculatorWindow.vc.showCalculatorView()
        }
    }

    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(presentCalculator), name: .init("PresentCalculator"), object: nil)
        let lashared = LAActivator.sharedInstance()
        if !lashared!.hasSeenListener(withName: listenerId) {
            lashared?.assign(LAEvent.event(withName: "libactivator.slide-in.bottom-right") as? LAEvent, toListenerWithName: listenerId)
        }
        lashared!.register(self, forName: listenerId)
    }
}

class SpringBoardHook: ClassHook<SpringBoard> {
    func applicationDidFinishLaunching(_ application : AnyObject) {
        orig.applicationDidFinishLaunching(application)
        
        calculatorWindow = CalculatorWindow(frame: UIScreen.main.bounds)
        
        listener = CardculatorListener()
        
        if !TweakPreferences.shared.preferencesShown.boolValue {
            let alert = UIAlertController(title: "Cardculator installed! 🎉", message: "Please go to Settings to enable the tweak", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            UIApplication.shared.windows[0].rootViewController?.present(alert, animated: true)
        }
    }
}
