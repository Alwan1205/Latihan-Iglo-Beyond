//
//  LoginViewController.swift
//  Latihan Iglo Beyond
//
//  Created by Muhammad Alwan on 08/09/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var passwordIsHidden: Bool = true
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var showPasswordImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        setupShowPasswordImageView()
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        loginValidation()
//        hitLoginAPI()
        goToHomeViewController()
    }
    
    private func setupTextField() {
        setupTextFieldDelegate()
        
        usernameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        usernameTextField.leftViewMode = .always
        usernameTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        usernameTextField.rightViewMode = .always
        usernameTextField.layer.borderWidth = 1
        usernameTextField.layer.borderColor = UIColor.gray.cgColor
        usernameTextField.layer.cornerRadius = 10
        
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        passwordTextField.leftViewMode = .always
        passwordTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 42, height: 0))
        passwordTextField.rightViewMode = .always
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.gray.cgColor
        passwordTextField.layer.cornerRadius = 10
    }
    
    private func setupShowPasswordImageView() {
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(showPasswordImageViewTapped))
        showPasswordImageView.isUserInteractionEnabled = true
        showPasswordImageView.addGestureRecognizer(viewTap)
    }
    
    @objc private func showPasswordImageViewTapped() {
        if passwordIsHidden {
            passwordTextField.isSecureTextEntry = false
            passwordIsHidden = false
            showPasswordImageView.image = UIImage(systemName: "eye")
        }
        else {
            passwordTextField.isSecureTextEntry = true
            passwordIsHidden = true
            showPasswordImageView.image = UIImage(systemName: "eye.slash")
        }
    }
    
    private func loginValidation() {
        guard let username = usernameTextField.text, !username.isEmpty else {
            AlertManager().showAlert(title: "Validation Error", message: "Username cannot be empty!", vc: self)
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            AlertManager().showAlert(title: "Validation Error", message: "Password cannot be empty!", vc: self)
            return
        }
    }
    
    private func hitLoginAPI() {
        LoginService().login(userName: usernameTextField.text ?? "", password: passwordTextField.text ?? "", completion: { data, error in
            if let error = error {
                AlertManager().showAlert(title: "API Error", message: error.localizedDescription, vc: self)
            }
            else {
                AlertManager().showAlert(title: "Success", message: "Login Success!", vc: self)
            }
        })
    }
    
    private func goToHomeViewController() {
        let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let homeVC = homeStoryboard.instantiateInitialViewController() as! HomeViewController
        homeVC.modalPresentationStyle = .fullScreen
        self.present(homeVC, animated: true)
    }

}

extension LoginViewController: UITextFieldDelegate {
    
    private func setupTextFieldDelegate() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
    
}
