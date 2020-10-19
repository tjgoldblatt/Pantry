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
    let recipes : [Recipe] = [Recipe(image: CollectionViewImage(type: "Recipe", title: "Spaghetti & Meatballs"), ingredients: ["Ground Beef" : "1 pound","Bread Crumbs":"1/2 cup", "Parmesan Cheese" : "1/3 cup", "Basil": "1 Tbsp", "Parsley" : "1/2 Tbsp","Salt" : "1 Tsp","Black Pepper":"1/4 Tsp","Garlic" : "4 cloves", "Egg": "1", "Olive Oil" : "5 Tbsp",  "Tomatoes" : "1 28oz. can", "Crushed Red Pepper Flakes" : "1 pinch", "Spaghetti" : "1 lb"], instructions: "1. Combine the ingredients from beef through egg in a bowl. Gently, using your fingers, mix it all together. If you have time, let the meat rest for 20 minutes. If not, proceed!\n2. Form the meat into golf-ball-sized balls. Heat the olive oil in a heavy skillet over medium-high heat. Cook the meatballs in batches, letting the first side get very brown and crispy before turning to cook the other sides. Once the outside is brown (don’t worry about the inside) remove from the pan and set aside.\n3. Once all of the meatballs have been browned, turn the heat down to medium-low. In a blender, combine the tomatoes, basil, red pepper flakes, and salt. Blend until smooth.\n4. Add the final 2 Tbsp of olive oil to the pan and cook the minced garlic cloves for 1 minute before adding the blended tomato mixture. When you add the tomatoes, scrape the pan vigorously to remove any scraps left from browning the meat.\n5. Bring the sauce to a simmer, and let cook for 10 minutes before adding the meatballs to the sauce.\n6. Let the meatballs cook in the simmering sauce for 15 minutes. During this time, cook your pasta fully.\n7. Serve hot over pasta, garnished with parmesan cheese!"), Recipe(image: CollectionViewImage(type: "Recipe", title: "Linguini Alfredo"), ingredients: ["Butter": "1 cup", "Heavy Cream": "2 cups", "Garlic" : "4 cloves", "Parmesan Cheese": "1 cup", "Parsley" : "1 Tsp", "Basil": "1 Tsp", "Salt" : "1 Tsp", "Black Pepper" : "1 Tsp", "Linguini" : "1 lb"], instructions: "1. Cook linguini as directed on box.\n2. While noodles cook heat butter and garlic in small saucepan over medium heat until butter is melted and garlic is browned.\n3. Add cream and heat until bubbling.\n4. Add cheese, parsley, basil, salt and pepper.\n5. Return drained noodles to kettle. Pour sauce over noodles, stirring gently until all are well coated.")]
    
    func filterRecipes(_ inputIngredients: [String : String], _ inputFilters: [String]) -> [Recipe] {
        var filteredRecipes : [Recipe] = []
        for recipe in recipes {
            for ingredient in inputIngredients {
                if(!filteredRecipes.contains(recipe) && recipe.ingredients.keys.contains(ingredient.key)) {
                    filteredRecipes.append(recipe)
                }
            }
        }
        return filteredRecipes
    }
    
    var body: some View {
        let topRecipes = [recipes[0], recipes[1]]
        let filteredRecipes = (inputIngredients.count != 0) ? filterRecipes(inputIngredients, inputFilters): topRecipes
        var filteredImages: [CollectionViewImage] = []
        filteredRecipes.forEach { (recipe) in
            filteredImages.append(recipe.image)
        }
        
        return CollectionView(images: filteredImages, recipes: filteredRecipes, activeIngredients: $inputIngredients)
    }
}
