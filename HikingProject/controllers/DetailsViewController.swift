//
//  DetailsViewController.swift
//  HikingProject
//
//  Created by Jesse viau on 2023-11-20.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var passedLaunch: Launch!

    var favouritesButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .done, target: DetailsViewController.self, action: #selector(addToFavourites))

    //MARK: IBOutlets
    @IBOutlet weak var missionName: UILabel!
    @IBOutlet weak var spacePatchImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = favouritesButton
        
        missionName.text = passedLaunch.missionName
        setCellImage(passedLaunch, spacePatchImage)
    }
    
    @objc func addToFavourites(sender: AnyObject) {
        print("hjxdbsdhjbv")
    }

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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
