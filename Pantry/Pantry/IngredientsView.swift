//
//  IngredientsView.swift
//  Pantry
//
//  Created by Yaniv Amiri on 10/11/20.
//

import SwiftUI

struct IngredientsView: View {
    let searchText: String
    
    @Binding var activeIngredients : [String : String]
    
    @State private var ingredients : [AutocompleteDetail] = []
    /* [CollectionViewImage] = [CollectionViewImage(type: "Ingredient", title: "Spaghetti"), CollectionViewImage(type: "Ingredient", title: "Angel Hair"), CollectionViewImage(type: "Ingredient", title: "Linguini"), CollectionViewImage(type: "Ingredient", title: "Garlic"), CollectionViewImage(type: "Ingredient", title: "Tomato"), CollectionViewImage(type: "Ingredient", title: "Salt"), CollectionViewImage(type: "Ingredient", title: "Onion"), CollectionViewImage(type: "Ingredient", title: "Thyme"), CollectionViewImage(type: "Ingredient", title: "Oregano"), CollectionViewImage(type: "Ingredient", title: "Parsley"), CollectionViewImage(type: "Ingredient", title: "Basil"), CollectionViewImage(type: "Ingredient", title: "Black Pepper"), CollectionViewImage(type: "Ingredient", title: "Bread Crumbs"), CollectionViewImage(type: "Ingredient", title: "Ground Beef"), CollectionViewImage(type: "Ingredient", title: "Crushed Red Pepper Flakes"), CollectionViewImage(type: "Ingredient", title: "Pasta Shells"), CollectionViewImage(type: "Ingredient", title: "Macaroni"), CollectionViewImage(type: "Ingredient", title: "Cheddar Cheese"), CollectionViewImage(type: "Ingredient", title: "Swiss Cheese"), CollectionViewImage(type: "Ingredient", title: "Parmesan Cheese"), CollectionViewImage(type: "Ingredient", title: "Butter"), CollectionViewImage(type: "Ingredient", title: "Mozarella"), CollectionViewImage(type: "Ingredient", title: "Italian Bread"), CollectionViewImage(type: "Ingredient", title: "Olive Oil")]
    
    func filterIngredients(_ input: String) -> [CollectionViewImage] {
        var filteredIngred : [CollectionViewImage] = []
        for image in ingredients {
            if(image.title.contains(input)) {
                filteredIngred.append(image)
            }
        }
        return filteredIngred
    }*/
    
    // autocompleteNames will return a list of names of ingredients that are close to our matching the input string
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
               // print(newCVI)
               // print(acResult)
                resultCVIs.append(newCVI)
            }
            return resultCVIs
        }
    
    var body: some View {
        let request = (searchText != "") ? autocompleteNames(searchText) : autocompleteNames("a")
        //let filteredIngredients = (searchText != "") ? filterIngredients(searchText): ingredients
       // print(request)
        return CollectionView(images: request, activeIngredients: $activeIngredients)
    }
}


struct IngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
