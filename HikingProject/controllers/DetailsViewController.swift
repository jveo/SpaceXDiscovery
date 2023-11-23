//
//  DetailsViewController.swift
//  HikingProject
//
//  Created by Jesse viau on 2023-11-20.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var passedLaunch: Launch!


    //MARK: IBOutlets
    @IBOutlet weak var missionName: UILabel!
    @IBOutlet weak var spacePatchImage: UIImageView!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var launchYearLabel: UILabel!
    @IBOutlet weak var launchSiteLabel: UILabel!
    @IBOutlet weak var rocketName: UILabel!
    @IBOutlet weak var rocketType: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        missionName.text = passedLaunch.missionName
        detailsTextView.text = passedLaunch.details
        launchYearLabel.text = "Launch Year: \(passedLaunch.launchYear)"
        launchSiteLabel.text = "Launch Site: \(passedLaunch.launchSite?.siteNameLong ?? "")"
        rocketName.text = "Rocket: \(passedLaunch.rocket?.rocketName ?? "")"
        rocketType.text = "Rocket Type: \(passedLaunch.rocket?.rocketType ?? "")"
        setCellImage(passedLaunch, spacePatchImage)
    }
    
    //MARK: IBAction
    
    

    
    //MARK: setCellImage method
     func setCellImage(_ launch: Launch, _ image: UIImageView) {
         //checks if the poster path exists for the selected movie if it doesn't, it displays a system image
         if(passedLaunch.links?.missionPatchSmall != nil){
            let url = URL(string: (passedLaunch.links?.missionPatchSmall)!)
            var image: UIImage!
            
            if let validatedUrl = url {
                URLSession.shared.dataTask(with: validatedUrl) {
                    (data, response, error) in
                    if let error = error { print(error) }
                    if let data = data {image = UIImage(data: data)}
                }.resume()
            }
            
            DispatchQueue.main.async {
                self.spacePatchImage.image = image
                
            }
        } else {
            let image = UIImage(systemName: "nosign")
            spacePatchImage.image = image
            spacePatchImage.backgroundColor = .darkGray
            spacePatchImage.tintColor = .gray
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "webSeg"){
            let destinationVC = segue.destination as? WebViewController
            if let url = passedLaunch.links?.videoLink{
                destinationVC?.webUrl = url
            }
        }
    }

}
