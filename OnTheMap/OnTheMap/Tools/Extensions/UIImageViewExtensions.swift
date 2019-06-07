//
//  UIImageViewExtensions.swift
//  OnTheMap
//
//  Created by Tiago Silva on 07/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

import Foundation
import Kingfisher 

extension UIImageView {
    
    func setImageBy(url: String?, contentMode: UIView.ContentMode?, placeholderImageName: String, completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) {
        let urlLink = URL(string: url ?? "")
        
        let imageContentMode = contentMode == nil ? .scaleAspectFill : contentMode
        
        self.contentMode = imageContentMode!
        self.kf.setImage(
            with: urlLink,
            placeholder: UIImage(named: placeholderImageName),
            options: [
                .processor(DefaultImageProcessor.default),
                .transition(.fade(1))
            ],
            completionHandler: completionHandler)
    }
    
    func setImageColorBy(hexColor: String) {
        let color = ViewUtils.UIColorFromHEX(hex: hexColor)
        
        setImageColorBy(uiColor: color)
    }
    
    func setImageColorBy(uiColor: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        
        self.image = templateImage
        self.tintColor = uiColor
    }
}
