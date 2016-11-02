//
//  MasterViewController.swift
//  MineNoter
//
//  Created by Mads Peter Emborg on 29/10/2016.
//  Copyright © 2016 Mads Peter Emborg. All rights reserved.
//

import UIKit

var returnFromDetail = 0;

extension MasterViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}

class MasterViewController: UITableViewController {

    let searchController = UISearchController(searchResultsController: nil)
    let emne = Emne(heading: "", timeStamp: NSDate(), noteText: "", photo1: NSData(), photoText1: "", photo2: NSData(), photoText2: "", photo3: NSData(), photoText3: "", pointer: 0)
    
    var filteredEmner = [Emne]()
    
    var detailViewController: DetailViewController? = nil
    var objects = [Any]()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        emne.load()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true;
        tableView.tableHeaderView = searchController.searchBar
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        if(returnFromDetail == 1){
            emne.save()
            tableView.reloadData()
            returnFromDetail = 0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(_ sender: Any) {
        let nytEmne = Emne(heading:"Nyt emne", timeStamp: NSDate(), noteText: "", photo1: NSData(), photoText1: "", photo2: NSData(), photoText2: "", photo3: NSData(), photoText3: "", pointer: 0);
        emner.insert(nytEmne, at: 0)
        emne.updatePointer()
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                currentIndex = indexPath.row
                if searchController.isActive && searchController.searchBar.text != "" {
                    currentIndex = filteredEmner[indexPath.row].pointer
                }
            //    let object = objects[indexPath.row] as! NSDate
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            //    controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredEmner.count
        } else {
            return emner.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        if searchController.isActive && searchController.searchBar.text != "" {
            cell.textLabel!.text = filteredEmner[indexPath.row].heading
            cell.detailTextLabel!.text = filteredEmner[indexPath.row].timeStamp.description
        } else {
            cell.textLabel!.text = emner[indexPath.row].heading
            cell.detailTextLabel!.text = emner[indexPath.row].timeStamp.description
        }
      //  let object = objects[indexPath.row] as! NSDate
      //  cell.textLabel!.text = object.description
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            objects.remove(at: indexPath.row)
            emner.remove(at: indexPath.row)
            emne.updatePointer()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredEmner = emner.filter { emne in
//            return emne.heading.lowercaseString.containsString(searchText.lowercaseString)
            return emne.heading.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }


}

