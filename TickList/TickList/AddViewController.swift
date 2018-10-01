//
//  AddViewController.swift
//  TickList
//
//  Created by Kashturi V on 2018-09-29.
//  Copyright © 2018 Kashturi V. All rights reserved.
//

import Foundation
import UIKit
protocol AddViewControllerDelegate: class {
    func addVCcancel(_ controller: AddViewController)
    func addVC(_ controller: AddViewController, didFinishAdding item: ListItem)
    func addVC(_ controller: AddViewController, didFinishEditing item: ListItem)
}
class AddViewController: UITableViewController,  UITextFieldDelegate {
    @IBOutlet weak var itemField: UITextField!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    weak var delegate: AddViewControllerDelegate?
    var editingItem: ListItem?
    @IBAction func cancel() {
        delegate?.addVCcancel(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = editingItem
        {
            itemField.text = item.text
            title = "Edit Item"
            doneButton.isEnabled = true
        }
    }
    @IBAction func done() {
        if let item = editingItem{
            item.text = itemField.text!
            delegate?.addVC(self, didFinishEditing: item)
        }
        else{
        let item = ListItem()
        item.text = itemField.text!
        item.checked = false
        delegate?.addVC(self, didFinishAdding: item)
        }
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        itemField.becomeFirstResponder()
    }
    func textField(_ itemField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String)-> Bool{
        let oldText = itemField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        doneButton.isEnabled = (newText.length > 0)
        return true
    }

}
