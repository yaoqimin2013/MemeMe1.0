//
//  ImageDisplayTableViewController.swift
//  MemeMe2.0
//
//  Created by Qimin Yao on 5/1/16.
//  Copyright © 2016 Qimin Yao. All rights reserved.
//

import UIKit

let tableViewWillReloadNotification = "tableViewWillReloadNotification"

class ImageDisplayTableViewController: UITableViewController {
    
    // Mark: Life Cycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: TableView DataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.memes.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    // MARK: TableView Delegate

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let meme = appDelegate.memes[indexPath.row]
        if let img = meme.savedImage, let topTxt = meme.topText, let bottomTxt = meme.bottomText {
            cell.imageView?.image = img
            cell.textLabel?.text = "\(topTxt)...\(bottomTxt)"
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // need to add codes here
    }

}
