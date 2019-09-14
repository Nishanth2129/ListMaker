//
//  ViewController.swift
//  ListMaker
//
//  Created by Padmasri Nishanth on 8/22/19.
//  Copyright © 2019 Padmasri Nishanth. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController : UITableViewController
{

    // Declaring the array
    var itemArray = [Item]()
    
    var selectedCategory : Category?
    {
        
     didSet{
    
    loadItems()
        
    }
    }
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // To Save the data for each individual Device
        print(dataFilePath)
        
}

   // MARK - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoitemCell")!
        
         let item = itemArray[indexPath.row]
        
         cell.textLabel?.text = item.title
        // to check the tickmark in the tableView
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK : Tableview Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
 
        // to add the CheckMark for the tableview Once its Clicked
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
         itemArray[indexPath.row].done = !itemArray[indexPath.row].done
 
         saveItems()
         
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
            
 
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            
            self.itemArray.append(newItem)
            self.saveItems()
    }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item "
            textField = alertTextField
         }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
       
    }
    
    // MARK : Model Manipulation Methods
    func saveItems()
    {
        
        do
        {
            try context.save()
            
        }catch
        {
            print("Error Saving Context ,\(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems(with request:NSFetchRequest<Item> = Item.fetchRequest(),predicate: NSPredicate? = nil)
    {
        let categorypredicate = NSPredicate(format: "parentCategory.name Matches %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate
        {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categorypredicate,additionalPredicate])
        }
        else
        {
            request.predicate = categorypredicate
        }
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categorypredicate,predicate])
//
//        request.predicate = compoundPredicate
        // to fetch the data for the request
      do{
               itemArray = try context.fetch(request)
            }catch{
                print("Error Fetching Data\(error)")
                
        }
        
    }
    
    }

//MARK : - Search Bar Methods
extension TodoListViewController : UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
         request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request,predicate: predicate)
 
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
    



