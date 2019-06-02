//
//  DefaultError.swift
//  FlickrFinder
//
//  Created by Tiago Silva on 22/05/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class DefaultError: Error {
    
    var message: String!
    
    init(message: String) {
        self.message = message
    }
}
