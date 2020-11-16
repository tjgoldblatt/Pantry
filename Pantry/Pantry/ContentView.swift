//
//  ContentView.swift
//  Pantry
//
//  Created by Yaniv Amiri on 10/9/20.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var activeIngredients : [String: String] = [:]
    @State private var recipes = [RecipeDetail]()
    @State private var filteredImages :  [CollectionViewImage] = []
    @State private var images = [CollectionViewImage]()
    @State private var ingredients = [AutocompleteDetail]()
    
    var body: some View {
        let ingredientView = IngredientsView(searchText: searchText, activeIngredients: $activeIngredients)
        let recipesView = RecipesView(inputFilters: [], inputIngredients: $activeIngredients)
    
            
        
        return NavigationView {
            ingredientView.navigationBarItems(
                leading: TextField("Search", text: $searchText).padding(.trailing, 20.0).padding(.leading, 20.0),
                trailing: NavigationLink("Recipes Page", destination: recipesView)
            )
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
