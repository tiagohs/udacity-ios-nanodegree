//
//  ViewController.swift
//  OnMap
//
//  Created by Tiago Silva on 16/05/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let imageUrl = URL(string: "https://upload.wikimedia.org/wikipedia/commons/4/4d/Cat_November_2010-1a.jpg")!
        
        let task = URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
            print("Complete")
            
            if error == nil {
                let image = UIImage(data: data!)
                
                self.imageView.image = image
            }
        }
        
        task.resume()
    }


}

