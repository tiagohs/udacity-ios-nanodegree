//
//  ViewController.swift
//  Click Counter
//
//  Created by Tiago Silva on 03/05/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var count = 0
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label = UILabel()
        label.frame = CGRect(x: 150, y: 150, width: 60, height: 60)
        label.text = "0"
        
        view.addSubview(label)
        
        let button = UIButton()
        button.frame = CGRect(x: 150, y: 250, width: 60, height: 60)
        button.setTitle("Click", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(ViewController.incrementCount), for: .touchUpInside)
        
        view.addSubview(button)
        
        let button2 = UIButton()
        button2.frame = CGRect(x: 150, y: 350, width: 60, height: 60)
        button2.setTitle("Click 2", for: .normal)
        button2.setTitleColor(UIColor.red, for: .normal)
        button2.addTarget(self, action: #selector(ViewController.changeBackgroundColor), for: .touchUpInside)
        
        view.addSubview(button2)
    }

    @IBAction func incrementCount() {
        self.count += 1
        self.label.text = "\(self.count)"
    }
    
    @IBAction func changeBackgroundColor() {
        self.label.backgroundColor = UIColor.red
    }
}

