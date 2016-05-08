//
//  ImageDisplayCollectionViewController.swift
//  MemeMe2.0
//
//  Created by Qimin Yao on 5/4/16.
//  Copyright © 2016 Qimin Yao. All rights reserved.
//

import UIKit

class ImageDisplayCollectionViewController: UICollectionViewController {
    
    var appDelegate: AppDelegate!
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        let space: CGFloat = 3.0
        let dimension = (self.view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
        
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = false
        self.collectionView?.reloadData()
    }
    
    // MARK: CollectionView Data Source Delegate
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return appDelegate.memes.count
    }
    
    // MARK: CollectionView Delegate
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCollectionViewCell", forIndexPath: indexPath) as! ImageViewCell
            
        if let meme = appDelegate.memes[indexPath.row] {
            
            if let img = meme.savedImage {
                cell.imageView.image = img
            }
        }
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        
        if let meme = appDelegate.memes[indexPath.row] {
        
            detailController.detailMeme = meme
            
            self.navigationController!.pushViewController(detailController, animated: true)
        }
    }
}
