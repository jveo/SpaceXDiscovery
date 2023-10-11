//
//  TasksTableTableViewController.swift
//  HikingProject
//
//  Created by Jesse viau on 2023-10-05.
//

import UIKit
import CoreData

class TasksTableTableViewController: UITableViewController {
    
    lazy var coreDataStack = CoreDataStack(modelName: "ToDoLists")
    var lists = [List]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchTasks()
    }

    @IBAction func addButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New List", message: "Enter the new list name", preferredStyle: .alert)
        alert.addTextField()
        
        let addListAction = UIAlertAction(title: "Add", style: .default){ [unowned self] _ in
            
            guard let listName = alert.textFields?[0].text, !listName.isEmpty else { return }
            
            //add to lists
            let newList = List(context: self.coreDataStack.managedContext)
            newList.listName = listName
            self.coreDataStack.saveContext()
            
            DispatchQueue.main.async {
//                RELOAD THE TABLE
                self.fetchTasks()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(addListAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    //MARK: - Datasource snapshot
    func loadTable() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, List>()
        snapshot.appendSections([.main])
        snapshot.appendItems(lists)
        snapshot.reloadItems(lists)
        tableDataSource.apply(snapshot)
    }
    
    //MARK: - Fetch Task Lists
    //TODO: Fetch from CORE DATA MODEL
    func fetchTasks(){
        let fetchRequest: NSFetchRequest<List> = List.createFetchRequest()
        
        let nameSort = NSSortDescriptor(key: "listName", ascending: true)
        
        fetchRequest.sortDescriptors = [nameSort]
        
        do {
            lists = try coreDataStack.managedContext.fetch(fetchRequest)
            self.loadTable()
        } catch {
            print("There was an error trying to fetch the lists - \(error.localizedDescription)")
        }
        
    }
    
    // MARK: - Table view data source
    private lazy var tableDataSource = UITableViewDiffableDataSource<Section, List>(tableView: tableView){
        tableview, indexPath, taskList in
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "checkListCell", for: indexPath)
        
        cell.textLabel?.text = taskList.listName
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }


}
