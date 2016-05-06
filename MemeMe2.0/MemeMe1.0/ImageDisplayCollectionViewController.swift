//
//  ImageDisplayCollectionViewController.swift
//  MemeMe2.0
//
//  Created by Qimin Yao on 5/4/16.
//  Copyright © 2016 Qimin Yao. All rights reserved.
//

import UIKit

class ImageDisplayCollectionViewController: UICollectionViewController {
    
    
    // MARK: Life Cycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // maybe we will write some codes here
        
    }
    
    // MARK: CollectionView Data Source Delegate
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        return appDelegate.memes.count
    }
    
    // MARK: CollectionView Delegate
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCollectionViewCell", forIndexPath: indexPath) as! ImageViewCell
    
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        if let meme = appDelegate.memes[indexPath.row] {
            
            if let img = meme.savedImage {
                cell.imageView.image = img
            }
        }
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        if let meme = appDelegate.memes[indexPath.row] {
        
            detailController.detailMeme = meme
            
            self.navigationController!.pushViewController(detailController, animated: true)
        }
    }
}
