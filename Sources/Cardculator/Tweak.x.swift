import Orion
import CardculatorC
import SwiftUI
import os

var calculatorWindow: CalculatorWindow!
var listener: CardculatorListener?
let log = Logger()


class CardculatorListener: NSObject, LAListener {
    let listenerId = "ovh.exerhythm.cardculator"

    func activator(_ activator: LAActivator?, receive event: LAEvent?) {
        event?.isHandled = true
        
        if calculatorWindow.vc.calculatorViewShown() {
            calculatorWindow.vc.hideCalculatorView()
        } else {
            calculatorWindow.vc.showCalculatorView()
        }
    }

    override init() {
        super.init()
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
        calculatorWindow.isHidden = false
        
        listener = CardculatorListener()
    }
}
