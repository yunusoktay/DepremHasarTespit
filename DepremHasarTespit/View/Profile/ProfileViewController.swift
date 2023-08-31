//
//  ProfileViewController.swift
//  DepremHasarTespit
//
//  Created by yunus oktay on 16.06.2023.
//

import UIKit

class ProfileViewController: BaseViewController {

    @IBOutlet var emailLabel: UILabel!
    let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfo()
    }

    func getInfo() {
            viewModel.fetchUserInfo { [weak self] user in
                if user != nil {
                    DispatchQueue.main.async {
                        self?.emailLabel.text = self?.viewModel.email
                    }
                } else {
                    DispatchQueue.main.async {
                        print("Kullanıcı bilgisi alınmadı")
                    }
                }
            }
        }
}
