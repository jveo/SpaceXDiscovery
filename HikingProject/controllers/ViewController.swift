//
//  ViewController.swift
//  HikingProject
//
//  Created by Jesse viau on 2023-10-05.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Aliases
    typealias DataSource = UITableViewDiffableDataSource<Section, Launch>
    lazy var tableDataSource = createDataSource()
    
    //MARK: IBOutlets
    @IBOutlet weak var spaceXTableView: UITableView!
    
    //MARK: Properties
    var latestCellIdentifier = "latestCell"
    var test = [Launch]()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLatestLaunch()
    }

    func fetchLatestLaunch(_ query: String? = nil){

        //https://api.spacexdata.com/v3/launches
        let api_url = "https://api.spacexdata.com/v3/launches"

        print(api_url)
        
        guard let url = URL(string: api_url) else { return }
        
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
                    
                    self.test = results
                    print("THE THING")
                    print(self.test)
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
        snapshot.appendItems(test)
        snapshot.reloadSections([.main])
        tableDataSource.apply(snapshot)
    }
    
    func createDataSource() -> DataSource{
        let dataSource = DataSource(tableView: spaceXTableView){
            tableView, index, launch in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: self.latestCellIdentifier, for: index) as! spaceXLatestTableViewCell
            //setting the characteristics of the movie cells
//            if let customFont = UIFont(name: "movie_title_font", size: 28){
//                //to support scalable fonts
//                cell.movieTitleLabel.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: customFont)
//            }
//            self.setCellImage(movie, cell)
//            cell.movieTitleLabel.text = movie.originalTitle
//            cell.movieVoteAverage.text = String(format: "%.f/8", movie.voteAverage)
            //cell.label.text = self.spacex_latest.id/
            cell.label.text = launch.missionName
            return cell
        }
        
        return dataSource
    }
    
}
