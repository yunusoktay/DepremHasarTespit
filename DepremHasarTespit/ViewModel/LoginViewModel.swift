//
//  LoginViewModel.swift
//  DepremHasarTespit
//
//  Created by yunus oktay on 12.07.2023.
//

import Foundation

class LoginViewModel {
    func signIn(with loginRequest: LoginUserRequest, completion: @escaping (Error?) -> Void) {
        let email = loginRequest.email
        let password = loginRequest.password
        
        AuthService.shared.signIn(with: loginRequest) { error in
            completion(error)
        }
    }
}

