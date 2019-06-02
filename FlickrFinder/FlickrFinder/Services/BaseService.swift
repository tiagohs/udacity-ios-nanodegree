//
//  BaseService.swift
//  FlickrFinder
//
//  Created by Tiago Silva on 22/05/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class BaseService {
    
    func doRequest(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let session = URLSession.shared
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request, completionHandler: completionHandler)
        
        task.resume()
    }
    
}
