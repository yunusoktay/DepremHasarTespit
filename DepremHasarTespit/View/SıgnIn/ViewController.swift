//
//  ViewController.swift
//  DepremHasarTespit
//
//  Created by yunus oktay on 11.06.2023.
//

import UIKit

class ViewController: BaseViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(keyboardOff))
        view.addGestureRecognizer(gestureRecognizer)
        passwordTextField.isSecureTextEntry = true
    }
    
    @objc func keyboardOff() {
        view.endEditing(true)
    }
    
    func configureButtons() {
        signInButton.applyCornerRadius(radius: 12)
        signUpButton.applyCornerRadius(radius: 12)
    }
    
    @IBAction func signInTapButton(_ sender: Any) {
        let loginRequest = LoginUserRequest(
            email: self.emailTextField.text ?? "",
            password: self.passwordTextField.text ?? ""
        )
               
        // Email check
        if !Validator.isValidEmail(for: loginRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        // Password check
        if !Validator.isPasswordValid(for: loginRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        viewModel.signIn(with: loginRequest) { [weak self] error in
            if let error = error {
                AlertManager.showSignInErrorAlert(on: self!, with: error)
                return
            }
        
            let nextVC = self?.storyboard?.instantiateViewController(withIdentifier: "tabBar") as! TabBarViewController
            self?.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    @IBAction func signUpTapButton(_ sender: Any) {
        let viewController = RegisterViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

