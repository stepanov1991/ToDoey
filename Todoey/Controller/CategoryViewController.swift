//
//  CategoryViewController.swift
//  Todoey
//
//  Created by user on 27.03.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    var categories : Results<Category>?
    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategory()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        guard let navBar = navigationController?.navigationBar else {
            fatalError("NavigationController does not exist")
        }
        navBar.backgroundColor = UIColor(hexString: "1D9BD6")
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        let newCategory = Category()
        
        let alert = UIAlertController(title: "Add new Todoye category.", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add category.", style: .default) { (action) in
            newCategory.name = textField.text!
            newCategory.backgroundColor = UIColor.randomFlat().hexValue()
            
            self.save(category: newCategory)
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add new category."
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        //MARK: - Data Methods
    }
    
    func save(category: Category)  {
        do {
            try realm.write {
                realm.add(category)
            }
        }
        catch{
            print("Error saving context \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategory()  {
        
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    //MARK: -  Delete Data From Swipe  
    
    override func updateModel(at indexPath: IndexPath) {
        
        if let cateryForDelete = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(cateryForDelete)
                }
            }
            catch{
                print("Deleting category error, \(error)")
            }
            
        }
    }
    
    
    // MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = categories?[indexPath.row]
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = item?.name ?? "No categories yet"
        cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].backgroundColor ?? "3758FF")
        cell.textLabel?.textColor = ContrastColorOf(cell.backgroundColor!, returnFlat: true)
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVS = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVS.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    
}


