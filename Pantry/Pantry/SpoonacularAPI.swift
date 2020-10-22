//
//  SpoonacularAPI.swift
//  Pantry
//
//  Created by TJ Goldblatt on 10/16/20.
//

import Foundation

struct MissedIngredient:Decodable {
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
    var missedIngredients: [MissedIngredient]
    var usedIngredients: [UsedIngredient]
    var image: String
    var missedIngredientCount: Int
}

struct RecipeResponse:Decodable{
    var response: [RecipeDetail]
}
