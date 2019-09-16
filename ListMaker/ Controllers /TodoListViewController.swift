//
//  ViewController.swift
//  ListMaker
//
//  Created by Padmasri Nishanth on 8/22/19.
//  Copyright © 2019 Padmasri Nishanth. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController : UITableViewController
{

    // Declaring the array
    var toDoItems : Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Category?
    {
        
     didSet{
    
        loadItems()
        
        }
    }
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // To Save the data for each individual Device
        print(dataFilePath)
        
}

   // MARK - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return toDoItems?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoitemCell")!
        
        if let item = toDoItems?[indexPath.row]
        {
            
        
         cell.textLabel?.text = item.title
        // to check the tickmark in the tableView
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        }
        else
        {
            cell.textLabel?.text = "No Items Added"
        }
            return cell
    }
        
    
    //MARK : Tableview Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
            if let item = toDoItems?[indexPath.row]
            {
                do {
                    try realm.write {
                    item.done = !item.done
                    }
                    
                }catch{
                    print("Error Saving Done Status\(error)")
                }
            }
        tableView.reloadData()

        }
    
    
    //MARK :- Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem)
    {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New List Item", message: "", preferredStyle:.alert)
        
        let action = UIAlertAction(title: "Add New Item", style: .default) { (action) in
            
            // What will happen if the user Clicks the item n our UIalert
            
            if let currentCategory = self.selectedCategory
            {
                do{
            
                    try self.realm.write
               {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                }
                }catch{
                    print("Error Saving New Items,\(error)")
                }
                
            }
            self.tableView.reloadData()
            }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item "
            textField = alertTextField
         }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
       
    }
    
    // MARK : Model Manipulation Methods
    
    
    func loadItems()
    {
        
        toDoItems = selectedCategory? .items.sorted(byKeyPath: "title", ascending: true)
         tableView.reloadData()
    }

    }

//MARK : - Search Bar Methods
extension TodoListViewController : UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // to filter with the search commands
        toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text! ).sorted(byKeyPath: "dateCreated", ascending: true)
 
        tableView.reloadData()

        }
func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchBar.text?.count == 0{
            loadItems()

            DispatchQueue.main.async {
                 searchBar.resignFirstResponder()
            }
            tableView.reloadData()
        }
}
}




    

    



