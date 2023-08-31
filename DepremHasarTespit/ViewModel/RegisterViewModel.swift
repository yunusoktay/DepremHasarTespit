//
//  RegisterViewModel.swift
//  DepremHasarTespit
//
//  Created by yunus oktay on 12.07.2023.
//

import Foundation
import Firebase

class RegisterViewModel {
    func registerUser(with userRequest: RegisterUserRequest, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().createUser(withEmail: userRequest.email, password: userRequest.password) { result, error in
            if let error = error {
                completion(false, error)
                return
            }
            
            guard let resultUser = result?.user else {
                completion(false, nil)
                return
            }
            
            let db = Firestore.firestore()
            db.collection("users")
                .document(resultUser.uid)
                .setData([
                    "email": userRequest.email,
                    "uuid": resultUser.uid,
                ]) { error in
                    if let error = error {
                        completion(false, error)
                        return
                    }
                    
                    completion(true, nil)
                }
        }
    }
}
