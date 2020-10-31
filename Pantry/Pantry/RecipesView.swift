//
//  RecipesView.swift
//  Pantry
//
//  Created by Yaniv Amiri on 10/11/20.
//

import SwiftUI

struct RecipesView: View {
    @Binding var inputIngredients : [String : String]
    
    
    var inputFilters : [String]
    @State private var recipes = [RecipeDetail]()
    
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
        
        var ingredients = ""
        if(inputIngredients.count != 0){
            for key in inputIngredients.keys {
                ingredients += (key == inputIngredients.first?.key) ? key.lowercased() : ",+ \(key.lowercased())"
            }
        }
        
        
        let request = SpoonacularRequest(ingredients: ingredients, number: 10, limitLicense: false, ranking: 1, ignorePantry: true)
        
        //print(request)
        
        request.getRecipes{ result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let results):
                recipes = results
            }
        }
        print(recipes)
        
//        let topRecipes = [recipes[0], recipes[1]]
//        let filteredRecipes = (inputIngredients.count != 0) ? filterRecipes(inputIngredients, inputFilters): topRecipes
        var filteredImages: [CollectionViewImage] = []
        recipes.forEach { (recipe) in
            filteredImages.append(CollectionViewImage(name: recipe.title, image: recipe.image, id: recipe.title.hashValue, aisle: "", possibleUnits: [], type: "Recipe"))
        }

        return CollectionView(images: filteredImages, recipes: recipes, activeIngredients: $inputIngredients)
    }
}
