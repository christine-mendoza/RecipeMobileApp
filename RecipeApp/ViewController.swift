//
//  ViewController.swift
//  RecipeApp
//
//  Created by Christine Mendoza on 4/15/22.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var category: CategoryViewController!
    var firstViewFlag = true
    
    var objects: [recipeObject] = []
    let categories = ["Favorites", "Breakfast", "Appetizers", "Seafood", "Meat", "Pasta", "Entrees", "Desserts"]
    var selected = ""
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return (categories.count)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = categories[row]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    var fileName = ""
    @IBOutlet weak var picker: UIPickerView!
    private func parseJSON() {
        
           let fileURL = Bundle.main.url(forResource: fileName, withExtension: ".json")
            if (FileManager.default.fileExists(atPath: fileURL!.path)) {
                    print("file found")
                    do {
                        let data = try Data(contentsOf: fileURL!)
                        let decoder = JSONDecoder()
                        objects = try decoder.decode(Array<recipeObject>.self, from: data)
                        
                     
                    }
                    catch {
                        print("error decoding file")
        
                    }// else no initalization
            } else {
              //  objects = ((NSArray(contentsOfFile: file.path)) as? [[String:String]])!
                print("file not found")
            }
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillResignActive(notification:)), name:UIApplication.willResignActiveNotification, object: nil)
     
       }
    
    override func viewWillAppear(_ animated: Bool) {
    
    }
    
    @IBAction func selectPress(_ sender: UIButton) {
        if (firstViewFlag == false) {
            let fileURL =  Bundle.main.url(forResource: fileName, withExtension: ".json")
              print(fileURL!)
              let array = (self.objects as NSArray)
              array.write(to: fileURL! as URL, atomically: true)
              print("data saved")
              
              let encoder = JSONEncoder()
              if let data =  try? encoder.encode(self.objects) {
                  do { try data.write(to: fileURL!)
                      print ("Wrote data using coding")
                  }
                  catch {
                      print("error writing to data file")
                  }
           //   }
          }
        
        }
        let vc = storyboard?.instantiateViewController(withIdentifier: "categoryView") as? CategoryViewController
        fileName = categories[picker.selectedRow(inComponent: 0)]
        parseJSON()
        vc?.mainVC = self
        vc?.modalPresentationStyle = .fullScreen
        vc?.data = categories[picker.selectedRow(inComponent: 0)]
        print(categories[picker.selectedRow(inComponent: 0)])
        present(vc!,animated: true)
        

    }
    
    @objc func applicationWillResignActive(notification:NSNotification) {
      //  let fileURL = self.dataFileURL()
      //  if(charTrack == "f") {
      let fileURL =  Bundle.main.url(forResource: fileName, withExtension: ".json")
        print(fileURL!)
        let array = (self.objects as NSArray)
        array.write(to: fileURL! as URL, atomically: true)
        print("data saved")
        
        let encoder = JSONEncoder()
        if let data =  try? encoder.encode(self.objects) {
            do { try data.write(to: fileURL!)
                print ("Wrote data using coding")
            }
            catch {
                print("error writing to data file")
            }
     //   }
    }

}

}

