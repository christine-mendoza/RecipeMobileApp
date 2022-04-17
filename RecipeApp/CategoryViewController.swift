//
//  CategoryViewController.swift
//  RecipeApp
//
//  Created by Christine Mendoza on 4/15/22.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var mainVC: ViewController!
    var recVC: RecipeViewController!
    var data = ""

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text! = data
        mainVC.firstViewFlag = false

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mainVC.objects.count
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            let obj = mainVC.objects[indexPath.row]
            cell.textLabel!.text = obj.recipe
            return cell
        }
    
    
    @IBAction func EditPush(_ sender: UIButton) {
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
        let objectToBeMoved = mainVC.objects[sourceIndexPath.row]
        mainVC.objects.remove(at: sourceIndexPath.row)
        mainVC.objects.insert(objectToBeMoved, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            mainVC.objects.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail"{
        let controller = (segue.destination as! RecipeViewController)
        controller.categoryViewController = self
        if segue.identifier == "ShowDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                controller.itemIndex = indexPath.row
                
            }
        }
        }
    }

    @IBAction func backPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    
    @IBAction func addPush(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "addView") as? AddViewController
        vc?.catView = self
        vc?.modalPresentationStyle = .fullScreen
        present(vc!,animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    @IBOutlet weak var tableView: UITableView!


}
