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

    var body: some View {
        NavigationView {
            IngredientsView(searchText: searchText, activeIngredients: $activeIngredients)
                .navigationBarItems(leading: TextField("Search", text: $searchText)
                    .padding(.trailing, 20.0)
                    .padding(.leading, 20.0), trailing: NavigationLink(destination: RecipesView(inputIngredients: $activeIngredients, inputFilters: [])) {
                            Text("Recipes Page")
                        }
                )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
