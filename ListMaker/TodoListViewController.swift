//
//  ViewController.swift
//  ListMaker
//
//  Created by Padmasri Nishanth on 8/22/19.
//  Copyright © 2019 Padmasri Nishanth. All rights reserved.
//

import UIKit

class TodoListViewController : UITableViewController
{

    // Declaring the array
    var itemArray = ["Steve Jobs","Elon Musk","Jeff Bezos","Mark ZuckerBerg"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [String]
        {
            itemArray = items
        }
     }

   // MARK - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
         let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoitemCell")!
         cell.textLabel?.text = itemArray[indexPath.row]
         return cell
    }
    
    //MARK : Tableview Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        // to get the output in the console
        // print([indexPath.row)
        //print(itemArray[indexPath.row])
        
        // to add the CheckMark for the tableview Once its Clicked
     
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else //
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }
        
        
        // to deselect the tableview once its selectted or to animate it
        tableView.deselectRow(at:indexPath, animated: true)
    }
    
    //MARK :- Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem)
    {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New List Item", message: "", preferredStyle:.alert)
        
        let action = UIAlertAction(title: "Add New Item", style: .default) { (action) in
            
            // What will happen if the user Clicks the item n our UIalert
            self.itemArray.append(textField.text!)
            
            // to reload and reflect the data in the TableView
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item "
            textField = alertTextField
         }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
       
    }
  
 }

