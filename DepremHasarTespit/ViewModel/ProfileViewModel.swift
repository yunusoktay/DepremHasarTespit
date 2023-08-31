//
//  ProfileViewModel.swift
//  DepremHasarTespit
//
//  Created by yunus oktay on 12.07.2023.
//

import Foundation

class ProfileViewModel {
    
    var email: String?
    

    func fetchUserInfo(completion: @escaping (Bool) -> Void) {
            Service.shared.fetchUserInfo { [weak self] user in
                if let user = user {
                    self?.email = user.email
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
}
