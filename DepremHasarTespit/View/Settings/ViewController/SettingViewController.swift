//
//  SettingViewController.swift
//  DepremHasarTespit
//
//  Created by yunus oktay on 14.06.2023.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var signOutButton: UIButton!
    
    
    let data: [Settings] = [
        Settings(title: "Profile", imageName: "profile"),
    ]
    
    let settingViewModel = SettingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        signOutButton.tintColor = .red
        settingViewModel.delegate = self
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        
        let nib = UINib(nibName: "SettingsTableViewCell", bundle: Bundle(for: SettingsTableViewCell.self))
        tableView.register(nib, forCellReuseIdentifier: "SettingsTableViewCell")
    }
    
    @IBAction func tapSignOutButton(_ sender: Any) {
        settingViewModel.signOut()
    }
}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingViewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settings = settingViewModel.data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath)as! SettingsTableViewCell
        cell.prefixLabel.text = settings.title
        cell.iconImageView.image = UIImage(named: settings.imageName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        settingViewModel.selectSetting(at: indexPath.row)
    }
}

extension SettingViewController: SettingViewModelDelegate {
    func didSelectSetting(at index: Int) {
        switch index {
        case 0:
            let nextVC = ProfileViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)
        default:
            print("Out of index")
        }
    }
    
    func didTapSignOut() {
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showLogoutError(on: self, with: error)
                return
            }
            navigationController?.popViewController(animated: true)
        }
    }
}
