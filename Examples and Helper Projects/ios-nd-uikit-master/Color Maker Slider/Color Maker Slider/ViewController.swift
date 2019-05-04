//
//  ViewController.swift
//  Color Maker Slider
//
//  Created by Tiago Silva on 03/05/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var redColorView: UISlider!
    @IBOutlet var blueColorView: UISlider!
    @IBOutlet var greenColorView: UISlider!
    @IBOutlet var viewColorView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        changeSliderBackgroundColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onChangeSliderValue() {
        changeSliderBackgroundColor()
    }
    
    private func changeSliderBackgroundColor() {
        let currentRedValue = redColorView.value
        let currentBlueValue = blueColorView.value
        let currentGreenValue = greenColorView.value
        
        let backgroundViewColor = UIColor(red: CGFloat(currentRedValue), green: CGFloat(currentGreenValue), blue: CGFloat(currentBlueValue), alpha: 1)
        
        viewColorView.backgroundColor = backgroundViewColor
    }

}

