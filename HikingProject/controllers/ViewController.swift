//
//  ViewController.swift
//  HikingProject
//
//  Created by Jesse viau on 2023-10-05.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    //MARK: - Aliases
    typealias DataSource = UITableViewDiffableDataSource<Section, Launch>
    lazy var tableDataSource = createDataSource()
    
    //MARK: IBOutlets
    @IBOutlet weak var spaceXTableView: UITableView!
    
    //MARK: Properties
    var latestCellIdentifier = "launchCell"
    var launches = [Launch]()
    
    //MARK: viewDidLoad Method
    override func viewDidLoad() {
        super.viewDidLoad()
        spaceXTableView.delegate = self
        spaceXTableView.dataSource = tableDataSource
        spaceXTableView.estimatedRowHeight = 150
    
        
        fetchUpcomingLaunches()
    }

    func fetchUpcomingLaunches(_ query: String? = nil){
        
        let all_launches_api_url = "https://api.spacexdata.com/v3/launches"
        let upcoming_apiUrl = "https://api.spacexdata.com/v3/launches/upcoming"
    
        
        guard let url = URL(string: all_launches_api_url) else { return }
        	
        let dataTask = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            if let error = error {
                print("There was a problem - \(error.localizedDescription)")
            } else {
                do{
                    guard let data = data else {
                        print("No data returned")
                        return
                    }
                    
                    let decoder = JSONDecoder()
                    let results = try decoder.decode([Launch].self, from: data)
                    
                    self.launches = results
                } catch DecodingError.valueNotFound(let error, let message){
                    self.errorMessage(error: "Value is missing: \(error)", context: message.debugDescription)
                    print("ERROR \(error)")
                } catch DecodingError.typeMismatch(let error, let message){
                    self.errorMessage(error: "Types do not match: \(error)", context: message.debugDescription)
                } catch DecodingError.keyNotFound(let error, let message){
                    self.errorMessage(error: "Incorrect property name: \(error)", context: message.debugDescription)
                } catch {
                    print(error)
                    self.errorMessage(error: "Unknown error has occurred", context:error.localizedDescription)
                }

                DispatchQueue.main.async {
                    self.createSnapshot()
                }
            }
            
        }
            
        dataTask.resume()
    }
    
    //MARK: error message handler
    func errorMessage(error: String, context: String){
        let alert = UIAlertController(title: error, message: context, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
        
    }
    
    //MARK: - Datasource methods
    func createSnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Launch>()
        snapshot.appendSections([.main])
        snapshot.appendItems(launches)
        snapshot.reloadSections([.main])
        tableDataSource.apply(snapshot)
    }
    
    //MARK: setCellImage method
     func setCellImage(_ launch: Launch, _ cell: spaceXLatestTableViewCell) {
         //checks if the poster path exists for the selected movie if it doesn't, it displays a system image
         if(launch.links?.missionPatchSmall != nil){
            let url = URL(string: (launch.links?.missionPatchSmall)!)
            var image: UIImage!
            
            if let validatedUrl = url {
                URLSession.shared.dataTask(with: validatedUrl) {
                    (data, response, error) in
                    if let error = error { print(error) }
                    if let data = data {image = UIImage(data: data)}
                }.resume()
            }
            
            DispatchQueue.main.async {
                cell.spaceImage.image = image
                
            }
        } else {
            let image = UIImage(systemName: "nosign")
            cell.spaceImage.image = image
            cell.spaceImage.backgroundColor = .darkGray
            cell.spaceImage.tintColor = .gray
        }
    }
    
    func createDataSource() -> DataSource{
        let dataSource = DataSource(tableView: spaceXTableView){
            tableView, index, launch in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: self.latestCellIdentifier, for: index) as! spaceXLatestTableViewCell
        
            
            self.setCellImage(launch, cell)
            cell.spaceImage.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 79, height: 100))
            cell.missionNameLabel.text = launch.missionName
            cell.launchYear.text = launch.launchYear
            cell.rocketName.text = launch.rocket?.rocketName
            return cell
        }
        return dataSource
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.latestCellIdentifier, for: indexPath) as! spaceXLatestTableViewCell
        print("PRESSED: \(cell)")
        return cell
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("PRESSED")
    }
    
    
    
}
