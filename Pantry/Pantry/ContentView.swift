//
//  ContentView.swift
//  Pantry
//
//  Created by Yaniv Amiri on 10/9/20.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search", text: $searchText)
                        .padding(.trailing, 20.0)
                        .padding(.leading, 20.0)
                    NavigationLink(destination: RecipesView()) {
                        Text("Recipes Page")
                            .padding(.trailing, 20.0)
                            .padding(.leading, 20.0)
                        
                    }
                }
                IngredientsView(searchText: searchText)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
