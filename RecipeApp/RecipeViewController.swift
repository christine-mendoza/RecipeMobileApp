//
//  RecipeViewController.swift
//  RecipeApp
//
//  Created by Christine Mendoza on 4/15/22.
//

import UIKit

class RecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var newIng = ""
    var categoryViewController: CategoryViewController!
    var itemIndex = 0

    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var prepLabel: UILabel!
    
    @IBOutlet weak var cookLabel: UILabel!
    
    @IBOutlet weak var directionsLabel: UITextView!
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryViewController.mainVC.objects[itemIndex].ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recCell", for: indexPath)
        cell.textLabel!.text = categoryViewController.mainVC.objects[itemIndex].ingredients[indexPath.row]
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = categoryViewController.mainVC.objects[itemIndex].recipe
        directionsLabel.text = categoryViewController.mainVC.objects[itemIndex].directions
        prepLabel.text = categoryViewController.mainVC.objects[itemIndex].prep
        cookLabel.text = categoryViewController.mainVC.objects[itemIndex].cook

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
       // tableView.reloadData()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        categoryViewController.mainVC.objects[itemIndex].directions = directionsLabel.text
    }
    
    @IBAction func backPress(_ sender: UIButton) {
    }
    
    @IBAction func editPress(_ sender: UIButton) {
        tableView.isEditing = !tableView.isEditing
        if sender.currentTitle == "Done" {
            sender.setTitle("Edit", for: .normal)
        }
        else {
            sender.setTitle("Done", for:.normal)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let objectToBeMoved = categoryViewController.mainVC.objects[itemIndex].ingredients[sourceIndexPath.row]
        categoryViewController.mainVC.objects[itemIndex].ingredients.remove(at: sourceIndexPath.row)
        categoryViewController.mainVC.objects[itemIndex].ingredients.insert(objectToBeMoved, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            categoryViewController.mainVC.objects[itemIndex].ingredients.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    @IBAction func addPress(_ sender: Any) {
        let alert = UIAlertController(title: "Add Ingredient:", message: nil, preferredStyle: .alert)
        alert.addTextField()
        alert.textFields![0].placeholder = "ingredient"
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: {(action) -> Void in
            self.newIng = alert.textFields![0].text!
            self.categoryViewController.mainVC.objects[self.itemIndex].ingredients.insert(self.newIng, at: 0)
            self.tableView.reloadData()
            print(self.newIng)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
