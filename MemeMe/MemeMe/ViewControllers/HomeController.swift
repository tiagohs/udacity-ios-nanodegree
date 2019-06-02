//
//  ViewController.swift
//  MemeMe
//
//  Created by Tiago Silva on 04/05/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    struct Meme {
        let topText: String
        let bottomText: String
        let originalImage: UIImage
        let memeImage: UIImage
    }
    
    @IBOutlet var pickImageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    var meme: Meme?
    
    var keyboardChanged = false
    
    let memeTextFieldDelegate = MemeTextFieldDelegate()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        if pickImageView.image == nil {
            shareButton.isEnabled = false
        }
        
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Impact", size: 50)!,
            NSAttributedString.Key.strokeWidth: -3.5
        ]
        
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        topTextField.textAlignment = .center
        topTextField.tintColor = UIColor.white
        bottomTextField.textAlignment = .center
        bottomTextField.tintColor = UIColor.white
        
        subscribeKeyboardObservable()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeKeyboardObservable()
    }
    
    override func viewDidLoad() {
        topTextField.delegate = memeTextFieldDelegate
        bottomTextField.delegate = memeTextFieldDelegate
        
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func save() {
        let topText = topTextField.text ?? ""
        let bottomText = bottomTextField.text ?? ""
        let originalImage = pickImageView.image!
        let memeImage = generateMemeImage()
        
        meme = Meme(topText: topText, bottomText: bottomText, originalImage: originalImage, memeImage: memeImage)
        
        shareMemeImage()
    }
    
    @IBAction func cancel(_ sender: Any) {
        topTextField.text = "Top"
        bottomTextField.text = "Bottom"
        
        dismissKeyboard()
        pickImageView.image = nil
        shareButton.isEnabled = false
    }
    
    @IBAction func pickImage(_ sender: UIBarButtonItem) {
        let tag = sender.tag
        
        switch tag {
        case 0:
            pickImage(sourceType: .photoLibrary)
            break;
        case 1:
            pickImage(sourceType: .camera)
        default:
            pickImage(sourceType: .photoLibrary)
        }
    }
    
    private func generateMemeImage() -> UIImage {
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return memedImage
    }
    
    private func shareMemeImage() {
        guard let memeImage = meme?.memeImage else { return }
        
        let activityViewController = UIActivityViewController(activityItems: [memeImage], applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    private func pickImage(sourceType: UIImagePickerController.SourceType) {
        let controller = UIImagePickerController()
        
        controller.delegate = self
        controller.sourceType = sourceType
        
        present(controller, animated: true, completion: nil)
    }
    
    func subscribeKeyboardObservable() {
        createKeyboardNotification(name: UIResponder.keyboardWillShowNotification, selector: #selector(keyboardWillAppear(_:)))
        createKeyboardNotification(name: UIResponder.keyboardWillHideNotification, selector: #selector(keyboardWillDisappear(_:)))
    }
    
    private func createKeyboardNotification(name: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }
    
    @objc func keyboardWillAppear(_ notification: Notification) {
        if !bottomTextField.isHighlighted {
            return
        }
        
        view.frame.origin.y -= getKeyboardHeight(notification)
        keyboardChanged = true
    }
    
    @objc func keyboardWillDisappear(_ notification: Notification) {
        if !keyboardChanged { return }
        
        view.frame.origin.y += getKeyboardHeight(notification)
        keyboardChanged = false
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardSize.cgRectValue.height
    }
    
    func unsubscribeKeyboardObservable() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

extension HomeController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            pickImageView.image = image
        }
        
        shareButton.isEnabled = true
        
        self.dismiss(animated: true, completion: nil)
        
    }

}

