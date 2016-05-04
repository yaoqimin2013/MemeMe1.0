//
//  UITextField+applySettings.swift
//  MemeMe1.0
//
//  Created by Qimin Yao on 5/1/16.
//  Copyright © 2016 Qimin Yao. All rights reserved.
//

import UIKit

let memeTextAttributes = [
    NSStrokeColorAttributeName : UIColor.whiteColor(),
    NSForegroundColorAttributeName : UIColor.whiteColor(),
    NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
    NSStrokeWidthAttributeName : -3.6
]

extension UITextField {

    func applyCustomizedSettings() {
        self.defaultTextAttributes = memeTextAttributes
        self.textAlignment = NSTextAlignment.Center
    }
}
