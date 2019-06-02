//
//  PickerImageViewController.swift
//  Color Maker Slider
//
//  Created by Tiago Silva on 04/05/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class PickerImageViewController: UIViewController {
    
    @IBOutlet var pickImageView: UIImageView!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
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
    
    private func pickImage(sourceType: UIImagePickerController.SourceType) {
        let controller = UIImagePickerController()
        
        controller.delegate = self
        controller.sourceType = sourceType
        
        present(controller, animated: true, completion: nil)
    }
    
}

extension PickerImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            pickImageView.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}
