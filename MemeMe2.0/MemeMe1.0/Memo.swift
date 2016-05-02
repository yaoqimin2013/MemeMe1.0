//
//  Memo.swift
//  MemeMe1.0
//
//  Created by Qimin Yao on 4/30/16.
//  Copyright © 2016 Qimin Yao. All rights reserved.
//

import Foundation
import UIKit

struct Memo {

    var topText: String?
    var bottomText: String?
    var originalImage: UIImage?
    var savedImage: UIImage?

    init(topText: String, bottomText: String, originalImage: UIImage? = nil, savedImage: UIImage? = nil) {
        self.topText  = topText
        self.bottomText = bottomText
        if let original = originalImage, saved = savedImage {
            self.originalImage = original
            self.savedImage = saved
        }
    }
}