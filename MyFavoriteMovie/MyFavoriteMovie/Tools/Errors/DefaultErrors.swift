//
//  DefaultErrors.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 02/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class DefaultError: Error {
    
    var message: String!
    
    init(message: String) {
        self.message = message
    }
}

