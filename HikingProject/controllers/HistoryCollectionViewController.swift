//
//  HistoryCollectionViewController.swift
//  HikingProject
//
//  Created by Jesse viau on 2023-11-24.
//

import UIKit

class HistoryCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Aliases
    typealias DataSource = UICollectionViewDiffableDataSource<Section, History>
    
    //MARK: Properties
    private let cellIdentifier = "historyCell"
    var historyItems = [History]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        title = "Historic Launches"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        collectionView.dataSource = collectionDataSource
        collectionView.delegate = self
        createSnapshot()
        fetchLaunches()
        // Do any additional setup after loading the view.
    }

    func fetchLaunches(){

        let api = "https://api.spacexdata.com/v3/history"
        guard let url = URL(string: api) else { return }
            
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
                    let results = try decoder.decode([History].self, from: data)
                    
                    self.historyItems = results
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
    
    //MARK: - Datasource
    //create the collection datasource
    private lazy var collectionDataSource = UICollectionViewDiffableDataSource<Section,History>(collectionView: collectionView){
        collectionView, indexpath, historicLaunch in
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexpath) as! HistoryCollectionViewCell
        cell.textLabel.text = historicLaunch.title

        return cell
    }
    

    
    //create the snapshot for loading images into the collectionview
    func createSnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, History>()
        snapshot.appendSections([.main])
        snapshot.appendItems(historyItems)
        collectionDataSource.apply(snapshot)
        snapshot.reloadSections([.main])
    }
    
    //MARK: error message handler
    func errorMessage(error: String, context: String){
        let alert = UIAlertController(title: error, message: context, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "historyDetailsSeg"){
            guard let indexPath = sender as? NSIndexPath else {return}
            let vc = segue.destination as! HistoryDetailsViewController
            vc.passedHistoricLaunch = historyItems[indexPath.row] as History
        }
    }
    
    //Perform segue when the user clicks a cell
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "historyDetailsSeg", sender: indexPath)
    }

    //number of sections to display within the collection view cell
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    //line spacing between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return historyItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
    
        // Configure the cell
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
