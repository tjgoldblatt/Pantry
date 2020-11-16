//
//  RecipesView.swift
//  Pantry
//
//  Created by Yaniv Amiri on 10/11/20.
//

import SwiftUI

struct RecipesView: View {
    
    var inputFilters : [String]
    @Binding var inputIngredients : [String : String]
    
//    func filterRecipes(_ inputIngredients: [String : String], _ inputFilters: [String]) -> [Recipe] {
//        var filteredRecipes : [Recipe] = []
//        for recipe in recipes {
//            for ingredient in inputIngredients {
//                if(!filteredRecipes.contains(recipe) && recipe.ingredients.keys.contains(ingredient.key)) {
//                    filteredRecipes.append(recipe)
//                }
//            }
//        }
//        return filteredRecipes
//    }
    
    var body: some View {
        return CollectionView( activeIngredients: $inputIngredients)
    }
}
