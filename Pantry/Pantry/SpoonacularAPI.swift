//
//  SpoonacularAPI.swift
//  Pantry
//
//  Created by TJ Goldblatt on 10/16/20.
//

import Foundation

struct Ingredient:Decodable, Identifiable {
    var id: String {
        name
    }
    
    var image: String
    var name: String
    var original: String
}

struct RecipeDetail:Decodable{
    var title: String
    var missedIngredients: [Ingredient]
    var usedIngredients: [Ingredient]
    var image: String
    var id: Int
    var missedIngredientCount: Int
}

struct RecipeResponse:Decodable{
    var response: [RecipeDetail]
}
