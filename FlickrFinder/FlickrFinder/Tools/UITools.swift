//
//  UITools.swift
//  FlickrFinder
//
//  Created by Tiago Silva on 31/05/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
