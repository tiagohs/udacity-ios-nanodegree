//
//  MemeTextFieldDelegate.swift
//  MemeMe
//
//  Created by Tiago Silva on 04/05/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    // When a user taps inside a textfield, the default text should clear.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    // When a user presses return, the keyboard should be dismissed. 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    
    
}
