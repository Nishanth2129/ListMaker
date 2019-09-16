//
//  CategoryViewController.swift
//  ListMaker
//
//  Created by Padmasri Nishanth on 9/13/19.
//  Copyright © 2019 Padmasri Nishanth. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController
{
    let realm = try! Realm()
    
    var categories : Results<Category>?
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
}
    
    //MARK :- TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet "
        
      return cell
    }
    
    // MARK :- Tableview delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
         performSegue(withIdentifier: "goToItems", sender:self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
       if  let indexPath = tableView.indexPathForSelectedRow
       {
        destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    // MARK :- Button Pressed
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem)
    {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle:.alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
       let newCategory = Category()
            newCategory.name = textField.text!
    
            self.save(category: newCategory)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add New Category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
}
    
    //MARK :- Data Manipulation Methods
    func save(category:Category)
    {
        
        do
        {
            try realm.write {
                realm.add(category)
            }
            
        }catch
        {
            print("Error Saving Context ,\(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories()
    {
         categories = realm.objects(Category.self)
       tableView.reloadData()
        
    }
    
}
    

