//
//  ViewController.swift
//  HikingProject
//
//  Created by Jesse viau on 2023-10-05.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
        spaceXTableView.backgroundColor = UIColor(named: "Space_Color")
        fetchUpcomingLaunches()
    }

    func fetchUpcomingLaunches(_ query: String? = nil){
        
        let all_launches_api_url = "https://api.spacexdata.com/v3/launches"
        //let upcoming_apiUrl = "https://api.spacexdata.com/v3/launches/upcoming"
    
        
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
            cell.missionNameLabel.text = launch.missionName
            cell.launchYear.text = launch.launchYear
            cell.rocketName.text = launch.rocket?.rocketName
            return cell
        }
        return dataSource
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //make sure that you can get an indexpath - this determines what row was tapped
        guard let index = spaceXTableView.indexPathForSelectedRow else { return }
        
        //use the index path to determine what movie object is in that row
        let itemToPass = tableDataSource.itemIdentifier(for: index)
        
        //determine where we are headed
        let destinationVC = segue.destination as! DetailsViewController
        //item to pass
        destinationVC.passedLaunch = itemToPass
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.latestCellIdentifier, for: indexPath) as! spaceXLatestTableViewCell
        print("PRESSED: \(cell)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("PRESSED")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return launches.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.black
            return headerView
        }
}



