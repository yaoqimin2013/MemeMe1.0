//
//  ImageViewController.swift
//  MemeMe2.0
//
//  Created by Qimin Yao on 5/3/16.
//  Copyright © 2016 Qimin Yao. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var detailMeme: Memo?
    
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        imageView.image = detailMeme?.savedImage
    }
    
}


