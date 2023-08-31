//
//  SettingViewModel.swift
//  DepremHasarTespit
//
//  Created by yunus oktay on 12.07.2023.
//

import Foundation

protocol SettingViewModelDelegate: AnyObject {
    func didSelectSetting(at index: Int)
    func didTapSignOut()
}

class SettingViewModel {
    weak var delegate: SettingViewModelDelegate?
    
    let data: [Settings] = [
        Settings(title: "Profile", imageName: "profile"),
    ]
    
    func selectSetting(at index: Int) {
        delegate?.didSelectSetting(at: index)
    }
    
    func signOut() {
        delegate?.didTapSignOut()
    }
}

