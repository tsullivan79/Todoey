//
//  ViewController.swift
//  Todoey
//
//  Created by Tom Sullivan on 1/4/18.
//  Copyright © 2018 Tom Sullivan. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    
    var itemArray = ["Walk dogs", "Feed Brian", "Cuddle Cats"]
    
    let defaults = UserDefaults.standard  //sets up the user defaults container
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
                itemArray = items
        }
        
        //this allows you to retrieve the last saved data from the UserDefaults file by loading data from that location when the app reloads on screen
        
        
    }

    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    
    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.row)//prints the selected cell to the console
        
        //print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
//MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField() //initializes empty UITextField object called textField (which can be called throughout the addButtonPressed method.
        
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert) //shows the UIAlert to the user with the title "Add New Todoey Item"
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //the line above defines the UIAlert action option, and style.
            //print(textField.text)  - a way to capture to the console what the user entered in the TextField
            
            self.itemArray.append(textField.text!) //adds the new to-do item to the to-do list array
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray") // saves the new user data in the UserDefaults persistent device storage
            
            
            self.tableView.reloadData() // reloads the table view with the new information added via the UIAlert
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    

}

