//
//  ViewController.swift
//  MemeMe1.0
//
//  Created by Qimin Yao on 4/27/16.
//  Copyright © 2016 Qimin Yao. All rights reserved.
//

import UIKit


class ViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var shareMomentButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    var toSaveImage: UIImage? = nil
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.whiteColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        //NSStrokeWidthAttributeName : 1
    ]
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.delegate = self
        
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.delegate = self
        
        cancelButton.enabled = false
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        self.subscribeToKeyboardNotification()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubsribeFromKeyboardNotification()
    }
    
    @IBAction func pickAnImage(sender: AnyObject) {
    
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        presentViewController(imagePicker, animated: true) {
            print("imagePickerView is presented. ")
        };
    }
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
    
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil);
    }
    
    @IBAction func shareMoment(sender: AnyObject) {
        
        let message = "My sharedMoment"
        if let image: UIImage = self.generateMemedImage() {
            self.toSaveImage = image
            let acitivityVC = UIActivityViewController.init(activityItems: [message, image], applicationActivities: nil)
            acitivityVC.completionWithItemsHandler = {acitivty, success, items, error in
                self.save()
            }
            self.presentViewController(acitivityVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancel(sender: AnyObject) {
    
    
    
    }
    
    // MARK: Observers
    
    func subscribeToKeyboardNotification() {
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIKeyboardWillShowNotification,
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIKeyboardWillHideNotification,
            object: nil)
    }
    
    func unsubsribeFromKeyboardNotification() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if self.bottomTextField.isFirstResponder() {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
            self.topTextField.userInteractionEnabled = false
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if self.bottomTextField.isFirstResponder() {
            self.view.frame.origin.y += getKeyboardHeight(notification)
            self.topTextField.userInteractionEnabled = true
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo!
        let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    // MARK: ImagePicker Delegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imagePickerView.image = image
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: TextField Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if self.topTextField.isFirstResponder() {
            self.topTextField.resignFirstResponder()
        }
        
        if self.bottomTextField.isFirstResponder() {
            self.bottomTextField.resignFirstResponder()
        }
        
        return true
    }
    
    // MARK: Image combine
    func save() {
        // Create the meme
        // need to add savedImage here
        let meme = Memo(topText: self.topTextField.text!, bottomText: self.bottomTextField.text!, originalImage: self.imagePickerView.image, savedImage: self.generateMemedImage())
        print(meme)
    }
    
    func generateMemedImage() -> UIImage {
        // hide toolbar and navigationbar
        
        // render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return memedImage
    }
}

