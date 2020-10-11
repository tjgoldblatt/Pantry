//
//  PantryApp.swift
//  Pantry
//
//  Created by Yaniv Amiri on 10/9/20.
//

import SwiftUI

@main
struct PantryApp: App {
    var body: some Scene {
        WindowGroup {
            IngredientsView()
            RecipesView()
            RecipeView()
        }
    }
}

struct PantryApp_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsView()
    }
}
