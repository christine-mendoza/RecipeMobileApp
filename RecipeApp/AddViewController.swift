//
//  AddViewController.swift
//  RecipeApp
//
//  Created by Christine Mendoza on 4/15/22.
//

import UIKit

class AddViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var catView: CategoryViewController!
    @IBOutlet weak var recipeField: UITextField!
    
    @IBOutlet weak var prepField: UITextField!
    
    @IBOutlet weak var cookField: UITextField!
    
    @IBOutlet weak var ingredientField: UITextField!
    
    @IBOutlet weak var directionsField: UITextView!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var addIngredients:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addCell", for: indexPath)
        cell.textLabel!.text = addIngredients[indexPath.row]
        return cell
        }

    @IBAction func savePress(_ sender: UIButton) {
        let newObject = recipeObject()
        newObject.recipe = recipeField.text!
        newObject.prep = prepField.text!
        newObject.cook = cookField.text!
        newObject.ingredients = addIngredients
        newObject.directions = directionsField.text!
        catView.mainVC.objects.insert(newObject, at: 0)
        catView.tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addPress(_ sender: UIButton) {
        addIngredients.insert(ingredientField.text!, at: 0)
        ingredientField.text = ""
        tableView.reloadData()
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
