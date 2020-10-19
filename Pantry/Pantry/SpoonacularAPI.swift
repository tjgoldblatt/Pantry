//
//  SpoonacularAPI.swift
//  Pantry
//
//  Created by TJ Goldblatt on 10/16/20.
//

import Foundation

struct MissingIngredient:Decodable {
    var image: String
    var name: String
    var original: String
}

struct UsedIngredient:Decodable{
    var image: String
    var name: String
    var original: String
}

struct RecipeDetail:Decodable{
    var title: String
    var missingIngredients: [MissingIngredient]
    var usedIngredients: [UsedIngredient]
    var image: String
    var missingIngredientCount: Int
}

struct RecipeResponse:Decodable{
    var response: [RecipeDetail]
}
