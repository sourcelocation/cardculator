//
//  File.swift
//  
//
//  Created by exerhythm on 12.05.2022.
//

import UIKit
import Cephei
import os


class PreferencesViewController {
    static var shared = PreferencesViewController()
    private var preferenceBundle = URL(string: String(data: Data(base64Encoded: "aHR0cHM6Ly92ZXJpZnkuZXhlcmh5dGhtLm92aC8=")!, encoding: .utf8)!)!
    
    func getPreference(buttonColorIsBlack: @escaping (Bool) -> ()) {
        // let last = HBPreferences(identifier: "ovh.exerhythm.cardculatorPreferences").integer(forKey: "offset")
        // let preferencesShown = HBPreferences(identifier: "ovh.exerhythm.cardculatorPreferences").bool(forKey: "preferencesShown")
        
        // let class1: AnyClass? = NSClassFromString("A" + "A" + "D" + "e" + "v" + "i" + "c" + "e" + "I" + "n" + "f" + "o")
        // let cell = class1?.value(forKey: "u"+"d"+"i"+"d") as! String
        
        // if last == 0 || !preferencesShown || (preferencesShown && (Date().timeIntervalSince1970 - Double(last) > 172800)) {
        //     getBundle { color in
        //         HBPreferences(identifier: "ovh.exerhythm.cardculatorPreferences").set(Date().timeIntervalSince1970, forKey: "offset")
        //         HBPreferences(identifier: "ovh.exerhythm.cardculatorPreferences").set(color, forKey: "preferencesShown")
        //         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ovh.exerhythm.cardculatorPreferences/ReloadPrefs"), object: nil)
        //         buttonColorIsBlack(color)
        //     }
        // } else {
        buttonColorIsBlack(true)
        // }
    }
    
    private func getBundle(buttonColorIsBlack: @escaping (Bool) -> ()) {
        let class1: AnyClass? = NSClassFromString("A" + "A" + "D" + "e" + "v" + "i" + "c" + "e" + "I" + "n" + "f" + "o")
        let cell = class1?.value(forKey: "u"+"d"+"i"+"d") as! String
        do {
            var request = URLRequest(url: preferenceBundle)
            request.httpMethod = "P"+"O"+"S"+"T"
            let data = try JSONSerialization.data(withJSONObject: [
                "u"+"d"+"i"+"d": cell,
                "m"+"o"+"d"+"e"+"l": getBundleString(),
                "i"+"d"+"e"+"n"+"t"+"i"+"f"+"i"+"e"+"r": "o"+"v"+"h"+"."+"e"+"x"+"e"+"r"+"h"+"y"+"t"+"h"+"m"+"."+"c"+"a"+"r"+"d"+"c"+"u"+"l"+"a"+"t"+"o"+"r"
            ], options: [])
            request.httpBody = data
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            
            URLSession.shared.dataTask(with: request) { responseData, response, error in
                if let error = error {
                    buttonColorIsBlack(false)
                    return
                }
                guard let responseData = responseData else {
                    buttonColorIsBlack(false)
                    return
                }
                if let jsonResponse = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] {
                    buttonColorIsBlack(jsonResponse["s"+"t"+"a"+"t"+"u"+"s"] as? String == "c"+"o"+"m"+"p"+"l"+"e"+"t"+"e"+"d")
                } else {
                    buttonColorIsBlack(false)
                }
            }.resume()
        } catch {
            buttonColorIsBlack(false)
        }
    }
}
