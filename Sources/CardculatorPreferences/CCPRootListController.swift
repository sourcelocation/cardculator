//
//  File.swift
//  
//
//  Created by exerhythm on 09.05.2022.
//

import CepheiPrefs
import Cephei
import UIKit
import SwiftUI

class CCPRootListController: HBRootListController {
    var validLicense: Bool = false
    
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
        
        
        PreferencesViewController.shared.getPreference { preferencesShown1 in
            if !preferencesShown1 && !self.validLicense {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Couldn't verify ownership :(", message: "Please reconnect to the internet and add this device to the device list on Havoc.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                    UIApplication.shared.windows[0].rootViewController?.present(alert, animated: true)
                }
            }
            HBPreferences(identifier: "ovh.exerhythm.cardculatorPreferences").setValue(preferencesShown1, forKey: "preferencesShown")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ovh.exerhythm.cardculatorPreferences/ReloadPrefs"), object: nil)
        }
    }
    
    override func tableViewStyle() -> UITableView.Style {
        validLicense = false
        return .insetGrouped
    }
}
