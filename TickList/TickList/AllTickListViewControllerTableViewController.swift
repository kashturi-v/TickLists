//
//  AllTickListViewControllerTableViewController.swift
//  TickList
//
//  Created by Kashturi V on 2018-09-29.
//  Copyright © 2018 Kashturi V. All rights reserved.
//

import UIKit

class AllTickListViewController: UITableViewController, AllListDetailViewControllerDelegate {
    var allticklist:[AllTickList]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func listDetailVCCancel(_ controller: AllListDetailViewController)
    {
        dismiss(animated: true, completion: nil)
    }
    func listDetailVC(_controller: AllListDetailViewController, didFinishAdding checklist: AllTickList)
    {
        let newItem = allticklist.count
        allticklist.append(checklist)
        let path = IndexPath(row: newItem, section: 0)
        let indexPaths = [path]
        tableView.insertRows(at: indexPaths, with: .automatic)
        dismiss(animated: true, completion: nil)
        
    }
    func listDetailVC(_controller: AllListDetailViewController, didFinishEditing checklist: AllTickList) {
        
        if let index = allticklist.index(of: checklist)
        {
            let indexPath = IndexPath(row: index, section:0)
            if let cell = tableView.cellForRow(at: indexPath)
            {
                let label = cell.viewWithTag(1000) as! UILabel
                label.text = checklist.name
            }
        }
        dismiss(animated: true, completion: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        allticklist = [AllTickList]()
        super.init(coder: aDecoder)
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allticklist.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = allticklist[indexPath.row]
        performSegue(withIdentifier: "tickListSegue", sender: item)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let tickListcell = tableView.dequeueReusableCell( withIdentifier: "allTickLists", for: indexPath)
            let item = allticklist[indexPath.row]
            let label = tickListcell.viewWithTag(2000) as! UILabel
            label.text = item.name
        
            return tickListcell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "tickListSegue"{
            let controller = segue.destination as! TickListViewController
            controller.checkList = sender as! AllTickList
        }
        else if segue.identifier == "editTickList"{
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! AllListDetailViewController
            controller.delegate = self
            controller.editingItem = nil
        }
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        allticklist.remove (at: indexPath.row)
        let deleteRow = [indexPath]
        tableView.deleteRows(at: deleteRow, with: .automatic)
    }
   
    
  

}
