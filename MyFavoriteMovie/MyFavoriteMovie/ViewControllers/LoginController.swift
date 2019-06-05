//
//  ViewController.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 02/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

// MARK: LoginController

class LoginController: BaseController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    var presenter: LoginPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.presenter = LoginPresenter()
        self.presenter.onInit(view: self, appDelegate: appDelegate)
        
        configureUI()
        
        subscribeToNotification(UIResponder.keyboardWillShowNotification, selector: #selector(keyboardWillShow))
        subscribeToNotification(UIResponder.keyboardWillHideNotification, selector: #selector(keyboardWillHide))
        subscribeToNotification(UIResponder.keyboardDidShowNotification, selector: #selector(keyboardDidShow))
        subscribeToNotification(UIResponder.keyboardDidHideNotification, selector: #selector(keyboardDidHide))
    }
    
}

// MARK: UITextFieldDelegate

extension LoginController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func resignIfFirstResponder(_ textField: UITextField) {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
    }
}

// MARK: LoginViewInterface

extension LoginController: LoginViewInterface {
    
    func onLoginComplete() {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "MoviesTabBarController") as! UITabBarController
        self.present(controller, animated: true, completion: nil)
        
        self.setUIEnabled(true)
        self.hideActivityIndicator()
    }
    
    func setUIEnabled(_ enabled: Bool) {
        usernameTextField.isEnabled = enabled
        passwordTextField.isEnabled = enabled
        loginButton.isEnabled = enabled
        
        if enabled {
            loginButton.alpha = 1.0
        } else {
            loginButton.alpha = 0.5
        }
    }
}

// MARK: LoginController [Actions]

private extension LoginController {
    
    @IBAction func loginClicked(_ sender: Any) {
        userDidTapView(self)
        
        if usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            self.onError(message: "Preenxer Username e Senha é obrigatório.")
        } else {
            setUIEnabled(false)
            
            self.showActivityIndicator()
            self.presenter.login(username: usernameTextField.text!, password: passwordTextField.text!)
        }
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        ViewUtils.openLink(link: Constants.TMDB.SignUpURL)
    }
    
    @IBAction func forgotPasswordClicked(_ sender: Any) {
        ViewUtils.openLink(link: Constants.TMDB.ForgotPasswordURL)
    }
    
    @IBAction func userDidTapView(_ sender: AnyObject) {
        resignIfFirstResponder(usernameTextField)
        resignIfFirstResponder(passwordTextField)
    }
    
}

// MARK: LoginController [Configure UI]

private extension LoginController {
    
    func configureUI() {
        configureTextField(usernameTextField)
        configureTextField(passwordTextField)
    }
    
    func configureTextField(_ textField: UITextField) {
        textField.delegate = self
    }
    
}
