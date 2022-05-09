//
//  File.swift
//  
//
//  Created by exerhythm on 06.05.2022.
//

import UIKit
import os


class CalculatorWindow: UIWindow {
    var vc: DraggableAreaViewController!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        windowLevel = UIWindow.Level.statusBar - 1

        vc = DraggableAreaViewController()
        rootViewController = vc
        isHidden = false
        rootViewController?.view.frame = frame
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//    func togglePresentation() {
//        if vc.calculatorViewShown() {
//            log.log("Hi, again 1")
//            vc.hideCalculatorView()
//        } else {
//            log.log("Hi, again 2")
//            vc.showCalculatorView()
//        }
//    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let vc = rootViewController else { return nil }
        let result = vc.view.hitTest(point, with: event)
        if result == self || result == vc.view {
            return nil
        } else {
            return result
        }
    }
}
