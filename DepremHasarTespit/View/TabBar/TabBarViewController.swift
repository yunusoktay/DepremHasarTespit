//
//  TabBarViewController.swift
//  DepremHasarTespit
//
//  Created by yunus oktay on 13.06.2023.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        let hexColor = 0x005493
        let color = colorFromHex(hexColor)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = color
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        navigationItem.title = "Deprem Hasar Tespit"
//        self.tabBar.tintColor = UIColor.white // tab bar icon tint color
//        self.tabBar.isTranslucent = false
//        UITabBar.appearance().barTintColor = UIColor.blue // tab bar background color

    }
    
    
    func colorFromHex(_ hex: Int) -> UIColor {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
