//
//  SettingsTableViewCell.swift
//  DepremHasarTespit
//
//  Created by yunus oktay on 15.06.2023.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet var prefixLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
