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
    let itemArray = ["Steve Jobs","Elon Musk","Jeff Bezos","Mark ZuckerBerg"]
    override func viewDidLoad() {
        super.viewDidLoad()
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
 }

