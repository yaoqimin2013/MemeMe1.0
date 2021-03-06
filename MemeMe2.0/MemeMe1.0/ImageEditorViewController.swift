//
//  ViewController.swift
//  MemeMe1.0
//
//  Created by Qimin Yao on 4/27/16.
//  Copyright © 2016 Qimin Yao. All rights reserved.
//

import UIKit


class ImageEditorViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var shareMomentButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toobar: UIToolbar!
    
    var toSaveImage: UIImage? = nil
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextField(topTextField)
        setupTextField(bottomTextField)
    }
    
    func setupTextField(textField: UITextField) {
        textField.applyCustomizedSettings()
        textField.delegate = self;
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        self.tabBarController?.tabBar.hidden = true
        if let img = toSaveImage {
            imagePickerView.image = img
        }
        
        subscribeToKeyboardNotification()

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        unsubsribeFromKeyboardNotification()
    }
    
    @IBAction func pickAnImage(sender: AnyObject) {
    
        presentImagePicker(.SavedPhotosAlbum)
    }
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
    
        presentImagePicker(.Camera)
    }
    
    func presentImagePicker(choseSource: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = choseSource
        presentViewController(imagePicker, animated: true, completion: nil);
    }
    
    @IBAction func shareMoment(sender: AnyObject) {
        
        let message = "My sharedMoment"
        if let image: UIImage = self.generateMemedImage() {
            toSaveImage = image
            let acitivityVC = UIActivityViewController.init(activityItems: [message, image], applicationActivities: nil)
            acitivityVC.completionWithItemsHandler = {acitivty, success, items, error in
                self.save()
                self.navigationController?.popViewControllerAnimated(true)
            }
            presentViewController(acitivityVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancel(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
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
            self.view.frame.origin.y = getKeyboardHeight(notification) * -1
            topTextField.userInteractionEnabled = false
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if self.bottomTextField.isFirstResponder() {
            self.view.frame.origin.y = 0
            topTextField.userInteractionEnabled = true
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
            imagePickerView.image = image
        }
        dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: TextField Delegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if topTextField.isFirstResponder() {
            topTextField.text = ""
        }
        if bottomTextField.isFirstResponder() {
            bottomTextField.text = ""
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if topTextField.isFirstResponder() {
            topTextField.resignFirstResponder()
        }
        
        if bottomTextField.isFirstResponder() {
            bottomTextField.resignFirstResponder()
        }
        
        return true
    }
    
    // MARK: Image combine
    func save() {
        // Create the meme
        // need to add savedImage here
        let meme = Memo(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image, savedImage: generateMemedImage())
        print(meme)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        if let _ = meme.originalImage {
            appDelegate.memes.append(meme)
        }
    }
    
    func generateMemedImage() -> UIImage {
        // hide toolbar and navigationbar
        toobar.hidden = true
        
        // render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        toobar.hidden = false
        
        return memedImage
    }
}

