//
//  BaseController.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 02/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class BaseController: UIViewController {
    
    var activityIndicatorContainer: UIView!
    var activityIndicator: UIActivityIndicatorView!
    
    var keyboardOnScreen = false
    
    public func onError(message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
            self.hideActivityIndicator()
        }))
        
        self.present(alert, animated: true)
    }

    func setupTransparentLightNavigationBar() {
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
    }
    
    func setupDarkNavigationBar() {
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
    }
    
    func showActivityIndicator() {
        if activityIndicator != nil && activityIndicatorContainer != nil {
            hideActivityIndicator()
        }
        
        activityIndicatorContainer = UIView()
        
        activityIndicatorContainer.frame = view.frame
        activityIndicatorContainer.center = view.center
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = view.center
        loadingView.backgroundColor = ViewUtils.UIColorFromHEX(hex: "#444444").withAlphaComponent(0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        
        loadingView.addSubview(activityIndicator)
        activityIndicatorContainer.addSubview(loadingView)
        view.addSubview(activityIndicatorContainer)
        activityIndicator.startAnimating()
    }
    
    @IBAction func logout() {
        dismiss(animated: true, completion: nil)
    }
    
    func hideActivityIndicator() {
        activityIndicator?.stopAnimating()
        activityIndicatorContainer?.removeFromSuperview()
        
        activityIndicator = nil
        activityIndicatorContainer = nil
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if !keyboardOnScreen {
            view.frame.origin.y -= keyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if keyboardOnScreen {
            view.frame.origin.y += keyboardHeight(notification)
        }
    }
    
    @objc func keyboardDidShow(_ notification: Notification) {
        keyboardOnScreen = true
    }
    
    @objc func keyboardDidHide(_ notification: Notification) {
        keyboardOnScreen = false
    }
    
    private func keyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = (notification as NSNotification).userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToNotification(_ notification: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }
    
    func unsubscribeFromAllNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
}
