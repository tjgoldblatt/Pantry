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
    @State private var request = [CollectionViewImage]()
    @State private var ingredients = [AutocompleteDetail]()
    
    func autocompleteNames(_ input: String) -> [CollectionViewImage] {
        let request = AutocompleteRequest(query: input, number: 25, metaInformation: true, intolerances: true)
        
        request.autocompleteResults{ result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let results):
                ingredients = results
            }
        }
        // Loops through autocompleteDetail objects, appending each name to a final list
        var resultCVIs : [CollectionViewImage] = []
        for ingred in ingredients{
            let newCVI = CollectionViewImage(name: ingred.name, image: ingred.image, id: ingred.id, aisle: ingred.aisle, possibleUnits: ingred.possibleUnits, type: "Ingredient")
            resultCVIs.append(newCVI)
        }
        return resultCVIs
    }
    
    var body: some View {
        NavigationView {
            IngredientsView(searchText: searchText, activeIngredients: $activeIngredients, request: request, ingredients: ingredients)
                .onAppear(perform:  {
                                request = (searchText != "") ? autocompleteNames(searchText) : autocompleteNames("a")
                            })
            .onChange(of: searchText, perform: { value in
                request = (searchText != "") ? autocompleteNames(searchText) : autocompleteNames("a")
            })
                .navigationBarItems(leading: TextField("Search", text: $searchText)
                    .padding(.trailing, 20.0)
                                        .padding(.leading, 20.0), trailing: NavigationLink(destination: RecipesView(inputFilters: [], inputIngredients: $activeIngredients, recipes: recipes).onAppear {
                                            var ingredients = ""
                                                    if(activeIngredients.count != 0){
                                                        for key in activeIngredients.keys {
                                                            ingredients += (key == activeIngredients.first?.key) ? key.lowercased() : ",+ \(key.lowercased())"
                                                        }
                                                    }
                                                    
                                                    
                                                    let request = SpoonacularRequest(ingredients: ingredients, number: 10, limitLicense: false, ranking: 1, ignorePantry: true)
                                                    
                                                    //print(request)
                                                    
                                                    request.getRecipes{ result in
                                                        switch result {
                                                        case .failure(let error):
                                                            print(error)
                                                        case .success(let results):
                                                            recipes.append(contentsOf: results)
                                                        }
                                                    }
                                                    print(recipes)
                                                    
                                            //        let topRecipes = [recipes[0], recipes[1]]
                                            //        let filteredRecipes = (inputIngredients.count != 0) ? filterRecipes(inputIngredients, inputFilters): topRecipes
                                                    
                                            }) {
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
