//
//  IngredientsView.swift
//  Pantry
//
//  Created by Yaniv Amiri on 10/11/20.
//

import SwiftUI

struct IngredientsView: View {
    @State private var searchText = "Search"
    
    func goToRecipes() {
        
    }
    
    var body: some View {
        VStack {
            HStack {
                TextField("Ingredient Search bar", text: $searchText).padding(.trailing, 40.0)
                    .padding(.leading, 20.0)
                Button(action: goToRecipes) {
                    Text("Go to Recipes Page").padding(.trailing, 20.0)
                }
            }
            LazyVStack {
                ForEach(1...10, id: \.self) { count in
                    Text("Ingredient")
                }
            }
        }
        
    }
}

struct IngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsView()
    }
}
