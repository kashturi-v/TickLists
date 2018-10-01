//
//  ViewController.swift
//  TickList
//
//  Created by Kashturi V on 2018-09-25.
//  Copyright © 2018 Kashturi V. All rights reserved.
//

import UIKit

class TickListViewController: UITableViewController, AddViewControllerDelegate{
    var todoListItem: [ListItem]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    required init?(coder aDecoder: NSCoder) {
        todoListItem = [ListItem]()
        super.init(coder: aDecoder)
        loadTickList()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)-> Int{
        return todoListItem.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tickListcell = tableView.dequeueReusableCell( withIdentifier: "TickListCell", for: indexPath)
        let item = todoListItem[indexPath.row]
        let label = tickListcell.viewWithTag(1000) as! UILabel
        label.text = item.text
        let checkMark = tickListcell.viewWithTag(1001) as! UILabel
        if item.checked {
            checkMark.text = "✅"
        }
        else {
            checkMark.text = ""
        }
        
        return tickListcell
        
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        todoListItem.remove (at: indexPath.row)
        let deleteRow = [indexPath]
        tableView.deleteRows(at: deleteRow, with: .automatic)
         saveTickLists()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let item = todoListItem[indexPath.row]
        item.togCheck()
        let tickListCell = tableView.cellForRow(at: indexPath)
        let checkMark = tickListCell?.viewWithTag(1001) as! UILabel
        if item.checked {
            checkMark.text = "✅"
        }
        else {
            checkMark.text = ""
        }
        tableView.deselectRow(at: indexPath, animated: true)
        saveTickLists()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addSegue" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! AddViewController
            controller.delegate = self
        }
        else if segue.identifier == "editSegue" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! AddViewController
            controller.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            {
               controller.editingItem = todoListItem[indexPath.row]
            }
        }
    }
    
    func addVCcancel(_ controller: AddViewController) {
        dismiss(animated: true, completion: nil)
    }
    func addVC(_ controller: AddViewController, didFinishAdding item: ListItem) {
        let newItem = todoListItem.count
        todoListItem.append(item)
        let path = IndexPath(row: newItem, section: 0)
        let indexPaths = [path]
        tableView.insertRows(at: indexPaths, with: .automatic)
        dismiss(animated: true, completion: nil)
         saveTickLists()
    }
    func addVC(_ controller: AddViewController, didFinishEditing item: ListItem) {
        if let index = todoListItem.index(of: item)
        {
            let indexPath = IndexPath(row: index, section:0)
            if let cell = tableView.cellForRow(at: indexPath)
            {
              let label = cell.viewWithTag(1000) as! UILabel
              label.text = item.text
            }
        }
         dismiss(animated: true, completion: nil)
        saveTickLists()
    }
    func dataPath() ->URL{
        let paths = FileManager.default.urls( for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("TickList.plist")
    }
    func loadTickList(){
        let path = dataPath()
        if let data = try? Data(contentsOf: path)
        {
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            todoListItem = unarchiver.decodeObject(forKey: "ListItem") as! [ListItem]
            unarchiver.finishDecoding()
        }
    }
    func saveTickLists () {
        let tickListData = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: tickListData)
        archiver.encode (todoListItem, forKey: "ListItem")
        archiver.finishEncoding()
        tickListData.write(to: dataPath(), atomically: true)
    }
}

