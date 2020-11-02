//
//  RecipeView.swift
//  Pantry
//
//  Created by Yaniv Amiri on 10/11/20.
//

import SwiftUI

struct RecipeView: View {
    let ingredients : [Ingredient]
    let instructions : String
    let activeIngredients : [String : String]
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(ingredients) { ingred in
                    Text(ingred.name).background(activeIngredients.keys.contains(ingred.name) ? Color.yellow : Color.white)
                    //Text("Amount: \(value)")
                }
                //Text("Instructions:\n\(instructions)").padding(.all, 20.0)
            }
        }
    }
}
