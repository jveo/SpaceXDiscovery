//
//  HistoryCollectionViewCell.swift
//  HikingProject
//
//  Created by Jesse viau on 2023-11-24.
//

import UIKit

class HistoryCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var textLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textLabel.contentMode = .scaleAspectFill
        textLabel.layer.cornerRadius = 12
        textLabel.textColor = .white
        
        
    }
}
