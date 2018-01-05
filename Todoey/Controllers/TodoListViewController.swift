//
//  ViewController.swift
//  Todoey
//
//  Created by Tom Sullivan on 1/4/18.
//  Copyright © 2018 Tom Sullivan. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard  //sets up the user defaults container
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem.title = "Buy Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem.title = "Destroy Demogorgon"
        itemArray.append(newItem3)
        
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
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
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary operator
        //value = condition ? valueIfTrue : valueIfFalse
        
        //the line below uses the ternary operator to replace the if/else statement immediately below it
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
    
        return cell
        
    }
    
    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.row)//prints the selected cell to the console
        
        //print(itemArray[indexPath.row])
        
        //the next line of code replaces the entire if/else block immediately below it

        itemArray[indexPath.row].done = !itemArray[indexPath.row].done //basically it sets the opposite bool for .done by toggling the status true/false
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
    
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
//MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField() //initializes empty UITextField object called textField (which can be called throughout the addButtonPressed method.
        
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert) //shows the UIAlert to the user with the title "Add New Todoey Item"
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //the line above defines the UIAlert action option, and style.
            //print(textField.text)  - a way to capture to the console what the user entered in the TextField
            
           
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem) //adds the new to-do item to the to-do list array
            
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

