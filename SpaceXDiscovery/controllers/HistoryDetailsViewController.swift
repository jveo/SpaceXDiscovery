//
//  HistoryDetailsViewController.swift
//  HikingProject
//
//  Created by Jesse viau on 2023-11-24.
//

import UIKit

class HistoryDetailsViewController: UIViewController {

    //MARK: Properties
    var passedHistoricLaunch: History!
    
    //MARK: IBOutlets
    @IBOutlet weak var headlineTextView: UITextView!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var flightNumberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        headlineTextView.text = passedHistoricLaunch.title
        headlineTextView.isUserInteractionEnabled = false
        flightNumberLabel.text = "Flight Number: \(passedHistoricLaunch.flightNumber ?? 0)"
        dateLabel.text = "Date: \(passedHistoricLaunch.eventDateUTC ?? "")"
        detailsTextView.text = passedHistoricLaunch.details
        detailsTextView.isUserInteractionEnabled = false
        
        
        
    }

}
