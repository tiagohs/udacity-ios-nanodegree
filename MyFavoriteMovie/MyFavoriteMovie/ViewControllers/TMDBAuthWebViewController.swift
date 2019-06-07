//
//  TMDBAuthWebViewController.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 07/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit
import WebKit

class TMDBAuthWebViewController: BaseController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var urlRequest: URLRequest?
    var requestToken: String? = nil
    var completionHandler: ((_ sucess: Bool,_ error: Error?) -> Void)? = nil
    
    override func viewDidLoad() {
        self.webView.navigationDelegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let urlRequest = self.urlRequest {
            self.webView.load(urlRequest)
        }
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension TMDBAuthWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        if let urlString = webView.url?.absoluteString {
            
            if urlString.contains(Constants.TMDB.AccountURL) {
                redirectToAuthorizationURL()
                return
            }
            
            if let requestToken = self.requestToken, urlString == "\(Constants.TMDB.AuthorizationURL)\(requestToken)/allow" {
                finishRequest()
            }
        }
    }
    
    private func redirectToAuthorizationURL() {
        if let urlRequest = self.urlRequest {
            self.webView.load(urlRequest)
        }
    }
    
    private func finishRequest() {
        dismiss(animated: true) {
            self.completionHandler?(true, nil)
        }
    }
}
