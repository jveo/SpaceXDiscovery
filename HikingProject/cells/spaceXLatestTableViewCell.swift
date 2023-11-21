//
//  spaceXLatestTableViewCell.swift
//  HikingProject
//
//  Created by Jesse viau on 2023-11-15.
//

import UIKit

class spaceXLatestTableViewCell: UITableViewCell {
    
    //MARK: Properties

    
    //MARK: IBOutlets
    @IBOutlet weak var spaceImage: UIImageView!
    @IBOutlet weak var missionNameLabel: UILabel!
    @IBOutlet weak var launchYear: UILabel!
    @IBOutlet weak var rocketName: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if let customFont = UIFont(name: "MegatransdemoRegular-8M9B0", size: 28){
            missionNameLabel.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: customFont)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
