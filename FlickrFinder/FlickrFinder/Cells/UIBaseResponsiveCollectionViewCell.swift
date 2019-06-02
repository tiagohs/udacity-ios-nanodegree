//
//  BaseResponsiveCollectionViewCell.swift
//  FlickrFinder
//
//  Created by Tiago Silva on 23/05/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class UIBaseResponsiveCollectionViewCell: UICollectionViewCell {
    
    private var isImageShadowBinded = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    func setupImageShadow(imageShadowView: UIImageView?, cornerRadius: CGFloat, shadowRect: CGRect) {
        if (!isImageShadowBinded) {
            guard let imageShadowView = imageShadowView else { return }
            
            imageShadowView.layer.cornerRadius = cornerRadius
            imageShadowView.layer.shadowColor = UIColor.black.cgColor
            imageShadowView.layer.shadowOffset = CGSize(width: 0, height: 3)
            imageShadowView.layer.shadowOpacity = 0.3
            imageShadowView.layer.shadowRadius = cornerRadius
            imageShadowView.layer.masksToBounds =  false
            imageShadowView.layer.shouldRasterize = true
            imageShadowView.layer.shadowPath = UIBezierPath(rect: shadowRect).cgPath
            
            isImageShadowBinded = true
        }
        
    }
}
