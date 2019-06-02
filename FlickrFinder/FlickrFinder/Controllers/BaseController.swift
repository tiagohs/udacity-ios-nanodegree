//
//  BaseController.swift
//  FlickrFinder
//
//  Created by Tiago Silva on 31/05/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class BaseController: UIViewController {
    
    func onError(message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
}
