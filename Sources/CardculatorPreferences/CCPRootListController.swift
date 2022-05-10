//
//  File.swift
//  
//
//  Created by exerhythm on 09.05.2022.
//

import CepheiPrefs
import Cephei
import UIKit

class CCPRootListController: HBRootListController {
    override var specifiers: NSMutableArray? {
        get {
            if let specifiers = value(forKey: "_specifiers") as? NSMutableArray {
                return specifiers
            } else {
                let specifiers = loadSpecifiers(fromPlistName: "Root", target: self)
                setValue(specifiers, forKey: "_specifiers")
                return specifiers
            }
        }
        set {
            super.specifiers = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.tintColor = UIColor(red:255/255, green:149/255, blue:0/255, alpha: 1)
        
//        let appearanceSettings = HBAppearanceSettings()
//        appearanceSettings.tintColor = view.tintColor
//        appearanceSettings.tableViewCellSeparatorColor = UIColor(white: 0, alpha: 0)
//        self.appearanceSettings = appearanceSettings
//
//        let rightBarButton = UIButton()
//        rightBarButton.setTitle("Respring", for: .normal)
//        rightBarButton.tintColor = .white
//        rightBarButton.backgroundColor = view.tintColor
//        rightBarButton.layer.cornerRadius = rightBarButton.requiredHeight / 1.5
//
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
        
    }
    
    override func tableViewStyle() -> UITableView.Style {
        return .insetGrouped
    }
    
//    @objc func respring(_ sender: Any?) {
//        if(FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/DynamicLibraries/shuffle.dylib")) {
//            HBRespringController.respringAndReturn(to: URL(string: "prefs:root=Tweaks&path=Cardculator"))
//        } else {
//            HBRespringController.respringAndReturn(to: URL(string: "prefs:root=Cardculator"))
//        }
//    }
}
