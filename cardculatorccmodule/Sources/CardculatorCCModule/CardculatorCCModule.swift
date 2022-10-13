import Orion
import CardculatorCCModuleC

class CardculatorCCModule: CCUIToggleModule {
    
    @objc override var iconGlyph: UIImage? {
        UIImage(named: "CCIcon", in: Bundle(for: type(of: self)), compatibleWith: nil)
	// return [UIImage imageNamed:@"CCIcon" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    }
    @objc override var selectedColor: UIColor? {
        .blue
    }
    @objc override var isSelected: Bool {
        get {
            false
        }
        set {
            super.refreshState()

            remLog("selected")
            NotificationCenter.default.post(name: .init("CCPresentCalculator"), object: nil)
        }
    }
}