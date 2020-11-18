//
//  SpoonacularAPI.swift
//  Pantry
//
//  Created by TJ Goldblatt on 10/16/20.
//

import Foundation

struct Ingredient:Decodable, Identifiable {
    var id: String? {
        name
    }
    
    var image: String?
    var name: String?
    var original: String?
}

struct RecipeDetail:Decodable{
    var title: String?
    var missedIngredients: Array<Ingredient>?
    var usedIngredients: Array<Ingredient>?
    var image: String?
    var id: Int?
    var missedIngredientCount: Int?
}

struct RecipeResponse:Decodable{
    var results: Array<RecipeDetail>?
}
