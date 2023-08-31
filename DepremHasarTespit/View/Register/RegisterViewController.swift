//
//  RegisterViewController.swift
//  DepremHasarTespit
//
//  Created by yunus oktay on 12.06.2023.
//

import UIKit

class RegisterViewController: BaseViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var registerButton: UIButton!
    
    private var registerViewModel: RegisterViewModel!

        override func viewDidLoad() {
            super.viewDidLoad()
            configureView()
            registerViewModel = RegisterViewModel()
        }
        
        func configureView() {
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(gestureRecognizer)
            registerButton.applyCornerRadius(radius: 12)
            passwordTextField.isSecureTextEntry = true
            let backButton = UIBarButtonItem()
            backButton.title = ""
            navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
            navigationController?.navigationBar.tintColor = UIColor.white
        }
        
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
        
        @IBAction func registerTapButton(_ sender: Any) {
            let registerUserRequest = RegisterUserRequest(
                email: emailTextField.text ?? "",
                password: passwordTextField.text ?? ""
            )
            
            // Email check
            if !Validator.isValidEmail(for: registerUserRequest.email) {
                AlertManager.showInvalidEmailAlert(on: self)
                return
            }
            
            // Password check
            if !Validator.isPasswordValid(for: registerUserRequest.password) {
                AlertManager.showInvalidPasswordAlert(on: self)
                return
            }
            
            registerViewModel.registerUser(with: registerUserRequest) { [weak self] wasRegistered, error in
                guard let self = self else { return }
                
                if let error = error {
                    AlertManager.showRegistrationErrorAlert(on: self, with: error)
                    return
                }
                
                if wasRegistered {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    AlertManager.showRegistrationErrorAlert(on: self)
                }
            }
        }
    }
