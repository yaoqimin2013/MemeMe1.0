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

    // MARK: LifeCycle
    
    override func viewDidLoad() {
        imageView.image = detailMeme?.savedImage
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true
    }
    
    // MARK: Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "EditImageSegue" {
            let controller = segue.destinationViewController as! ImageEditorViewController
            controller.toSaveImage = detailMeme?.savedImage
        }
    }
}


