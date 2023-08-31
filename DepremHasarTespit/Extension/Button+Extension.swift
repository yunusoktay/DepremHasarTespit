//
//  Button+Extension.swift
//  DepremHasarTespit
//
//  Created by yunus oktay on 12.06.2023.
//

import Foundation
import UIKit

extension UIButton {
    func applyCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}


