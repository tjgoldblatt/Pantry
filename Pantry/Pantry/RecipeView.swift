//
//  RecipeView.swift
//  Pantry
//
//  Created by Yaniv Amiri on 10/11/20.
//

import SwiftUI

struct RecipeView: View {
    let ingredients : [String: String]
    let instructions : String
    let activeIngredients : [String : String]
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(ingredients.sorted(by: >), id: \.key) { key, value in
                    Text(key).background(activeIngredients.keys.contains(key) ? Color.yellow : Color.white)
                    Text("Amount: \(value)")
                }
                Text("Instructions:\n\(instructions)").padding(.all, 20.0)
            }
        }
    }
}
