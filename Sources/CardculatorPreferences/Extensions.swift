//
//  File.swift
//  
//
//  Created by exerhythm on 09.05.2022.
//

import UIKit

extension UIButton {
    public var requiredHeight: CGFloat {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: titleLabel!.frame.width, height: CGFloat.greatestFiniteMagnitude))
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleLabel?.font = titleLabel?.font
        button.titleLabel?.text = titleLabel?.text
        button.titleLabel?.attributedText = titleLabel?.attributedText
        button.titleLabel?.sizeToFit()
        return button.titleLabel!.frame.height
    }
}

func getBundleString() -> String {
    if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] { return simulatorModelIdentifier }
    var sysinfo = utsname()
    uname(&sysinfo) // ignore return value
    return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
}
