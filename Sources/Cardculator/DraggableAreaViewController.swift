//
//  DraggableAreaViewController.swift
//
//
//  Created by exerhythm on 05.05.2022.
//

import os
import SwiftUI

class DraggableAreaViewController: UIViewController {
    
    private var calcView: UIView!
    private var lastSwipeBeginningPoint: CGPoint?
    
    var safeAreaInsets: UIEdgeInsets {
        (view.window?.windowScene?.windows.first!.safeAreaInsets)!
    }
    
    func calculatorViewShown() -> Bool {
        return calcView != nil
    }
    
    func showCalculatorView() {
        log.log("cardculator showCalculatorView")
        let ratio = 0.6
        let padding: CGFloat = 10
        let calcwidth = view.bounds.width - padding * 2
        let calculatorView = CalculatorView(close: hideCalculatorView)
            .frame(width: calcwidth, height: calcwidth * ratio)
        
        let calcVC = UIHostingController(rootView: calculatorView)
        addChild(calcVC)
        calcVC.view.frame = .init(x: padding, y: view.bounds.height - calcwidth * ratio - padding - safeAreaInsets.bottom, width: calcwidth, height: calcwidth * ratio)
        view.addSubview(calcVC.view)
        calcVC.didMove(toParent: self)
        calcView = calcVC.view
        calcView.backgroundColor = .clear
        calcView.translatesAutoresizingMaskIntoConstraints = false
        calcView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
        calcView.alpha = 0
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.calcView.alpha = 1
        })
    }
    func hideCalculatorView() {
        log.log("cardculator hideCalculatorView")
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.calcView.alpha = 0
        }, completion: { _ in
            self.calcView = nil
        })
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        log.log("cardculator handlePan")
        if gesture.state == .ended  {
            let velocity = gesture.velocity(in: view)
            print(velocity.y)
            var calcY: CGFloat = 0
            let minVelocity: CGFloat = 300
            
            if velocity.y < -minVelocity || (!(velocity.y > minVelocity) && gesture.location(in: view).y < view.bounds.height / 2) {
                calcY = calcView.frame.height / 2 + safeAreaInsets.top
            } else {
                calcY = view.bounds.height - calcView.frame.height / 2 - 10 - safeAreaInsets.bottom
            }
            
            let finalPoint = CGPoint(x: calcView.center.x, y: calcY)
            
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: abs(velocity.y) / 70, options: .curveEaseInOut, animations: {
                self.calcView.center = finalPoint
            })
        }
        let translation = gesture.translation(in: view)
        guard let gestureView = gesture.view else {
            return
        }
        gestureView.center = CGPoint(
            x: gestureView.center.x,
            y: gestureView.center.y + translation.y
        )
        gesture.setTranslation(.zero, in: view)
    }
}
