//
//  checkBoxTableViewCell.swift
//  HikingProject
//
//  Created by Jesse viau on 2023-10-12.
//

import UIKit

class checkBoxTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkListBox: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
