//
//  recipeObject.swift
//  RecipeApp
//
//  Created by Christine Mendoza on 4/15/22.
//

import UIKit

class recipeObject: NSObject, Codable {
    var category: String = ""
    var prep: String = ""
    var cook: String = ""
    var recipe: String = ""
    var ingredients: [String] = []
    var directions: String  = ""

}
