//
//  DraggableAreaViewController.swift
//
//
//  Created by exerhythm on 05.05.2022.
//

import os
import SwiftUI

class DraggableAreaViewController: UIViewController {
    
    private var calcUIView: UIView?
    private var lastSwipeBeginningPoint: CGPoint?
    
    var safeAreaInsets: UIEdgeInsets {
        (view.window?.windowScene?.windows.first!.safeAreaInsets)!
    }
    
    var maxCalcWidth: CGFloat {
        remLog(PreferenceManager.shared.settings.isEnabledTweak)
        switch PreferenceManager.shared.settings.selectedStyle {
        case .card, .cardAlt:
            return 400
        case .stock:
            return 250
        case .square:
            return 300
        }
    }
    var calcSizeRatio: CGFloat {
        switch PreferenceManager.shared.settings.selectedStyle {
        case .card, .cardAlt:
            return 0.6
        case .stock:
            return 1.45
        case .square:
            return 1
        }
    }
    
    var speedK: Double {
        PreferenceManager.shared.settings.speed / 100
    }
    var bigScreen: Bool {
        view.bounds.width > maxCalcWidth
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.stylePrefChanged(notification:)), name: Notification.Name("StylePrefChanged"), object: nil)

    }
    
    @objc func stylePrefChanged(notification: NSNotification) {
        guard calculatorViewShown() else { return }
        hideCalculatorView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
            self.showCalculatorView()
        })
    }
    
    func calculatorViewShown() -> Bool {
        return calcUIView != nil
    }
    
    func showCalculatorView() {
        let padding: CGFloat = 10
        let calcwidth = min(maxCalcWidth, view.bounds.width - padding * 2)
        let calcheight = calcwidth * calcSizeRatio
        
        let calculatorView = CalculatorView(close: hideCalculatorView).frame(width: calcwidth, height: calcheight)
        
        if calcUIView == nil {
            let calcVC = UIHostingController(rootView: calculatorView)
            addChild(calcVC)
            view.addSubview(calcVC.view)
            calcVC.didMove(toParent: self)
            calcUIView = calcVC.view
        }
        
        let resY = view.bounds.height - calcheight - padding - safeAreaInsets.bottom
        calcUIView!.frame = .init(x: padding, y: resY, width: calcwidth, height: calcheight)
        
        
        calcUIView!.backgroundColor = .clear
        calcUIView!.translatesAutoresizingMaskIntoConstraints = false
        calcUIView!.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
        calcUIView!.alpha = 0
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.calcUIView!.alpha = 1
        })
    }
    func hideCalculatorView() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.calcUIView?.alpha = 0
        }, completion: { _ in
            self.calcUIView?.removeFromSuperview()
            self.calcUIView = nil
        })
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let calcView = calcUIView else { return }
        let translation = gesture.translation(in: view)
        guard let gestureView = gesture.view else {
            return
        }
        
        if gesture.state == .ended {
            let velocity = gesture.velocity(in: view)
            
            var calcX: CGFloat = calcView.center.x
            var calcY: CGFloat = 0
            var animationTime: TimeInterval = 0
            let minVelocity: CGFloat = 300
            
            if PreferenceManager.shared.settings.snapToCorners {
                animationTime = 0.75
                if velocity.y < -minVelocity || (!(velocity.y > minVelocity) && gesture.location(in: view).y < view.bounds.height / 2) {
                    calcY = calcView.frame.height / 2 + max(10, safeAreaInsets.top)
                } else {
                    calcY = view.bounds.height - calcView.frame.height / 2 - max(10, safeAreaInsets.bottom)
                }
                
                if velocity.x < -minVelocity || (!(velocity.x > minVelocity) && gesture.location(in: view).x < view.bounds.width / 2) {
                    calcX = calcView.frame.width / 2 + max(10, safeAreaInsets.left)
                } else {
                    calcX = view.bounds.width - calcView.frame.width / 2 - max(10, safeAreaInsets.right)
                }
            } else {
                animationTime = 0.3
                calcX = (0...view.bounds.width).clamp(gestureView.center.x + translation.x + velocity.x / 15)
                calcY = (0...view.bounds.height).clamp(gestureView.center.y + translation.y + velocity.y / 15)
            }
            
            let finalPoint = CGPoint(x: calcX, y: calcY)
            let velK = view.bounds.width / 4
            UIView.animate(withDuration: animationTime / speedK, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: sqrt(pow(velocity.y, 2) + pow(velocity.x, 2)) / velK * CGFloat(speedK), options: .curveEaseInOut, animations: {
                self.calcUIView?.center = finalPoint
            })
        }
        gestureView.center = CGPoint(
            x: gestureView.center.x + translation.x,
            y: gestureView.center.y + translation.y
        )
        gesture.setTranslation(.zero, in: view)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: nil, completion: {_ in
            UIView.setAnimationsEnabled(true)
        })
        UIView.setAnimationsEnabled(false)
        super.viewWillTransition(to: size, with: coordinator);
        
//        hideCalculatorView()
        if calcUIView != nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.showCalculatorView()
            })
        }
    }
}
