//
//  AllListDetailViewControllerTableViewController.swift
//  TickList
//
//  Created by Kashturi V on 2018-09-30.
//  Copyright © 2018 Kashturi V. All rights reserved.
//
import Foundation
import UIKit

protocol AllListDetailViewControllerDelegate: class {
    func listDetailVCCancel(_ controller: AllListDetailViewController)
    func listDetailVC(_controller: AllListDetailViewController, didFinishAdding checklist: AllTickList)
    func listDetailVC(_controller: AllListDetailViewController, didFinishEditing checklist: AllTickList)
    
}

class AllListDetailViewController: UITableViewController, UITextFieldDelegate{
    @IBOutlet weak var doneButton: UIBarButtonItem!
    

    
    weak var delegate: AllListDetailViewControllerDelegate?
    var editingItem: AllTickList?
    @IBAction func cancel() {
        delegate?.listDetailVCCancel(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = editingItem
        {
            itemField.text = item.name
            title = "Edit Item"
            doneButton.isEnabled = true
        }
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        itemField.becomeFirstResponder()
    }
    
    @IBAction func done() {
        if let item = editingItem{
            item.name = itemField.text!
            delegate?.listDetailVC(_controller: self, didFinishEditing: item)
        }
        else{
             let item = AllTickList()
             item.name = itemField.text!
            delegate?.listDetailVC(_controller: self, didFinishAdding: item)
        }
    }
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath)->IndexPath? {
        return nil
    }
    func textField(_ itemField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String)-> Bool{
        let oldText = itemField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        doneButton.isEnabled = (newText.length > 0)
        return true
    }
}
