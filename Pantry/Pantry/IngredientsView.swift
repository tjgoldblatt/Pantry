//
//  IngredientsView.swift
//  Pantry
//
//  Created by Yaniv Amiri on 10/11/20.
//

import SwiftUI

struct IngredientsView: View {
    let searchText: String
    
    let ingredients : [CollectionViewImage] = [CollectionViewImage(type: "Ingredient", title: "Thin Spaghetti"), CollectionViewImage(type: "Ingredient", title: "Angel Hair"), CollectionViewImage(type: "Ingredient", title: "Linguini"), CollectionViewImage(type: "Ingredient", title: "Garlic"), CollectionViewImage(type: "Ingredient", title: "Tomato"), CollectionViewImage(type: "Ingredient", title: "Salt"), CollectionViewImage(type: "Ingredient", title: "Onion"), CollectionViewImage(type: "Ingredient", title: "Thyme"), CollectionViewImage(type: "Ingredient", title: "Oregano"), CollectionViewImage(type: "Ingredient", title: "Parsley"), CollectionViewImage(type: "Ingredient", title: "Course Black Pepper"), CollectionViewImage(type: "Ingredient", title: "Bread Crumbs"), CollectionViewImage(type: "Ingredient", title: "Ground Beef"), CollectionViewImage(type: "Ingredient", title: "Red Chili Flakes"), CollectionViewImage(type: "Ingredient", title: "Pasta Shells"), CollectionViewImage(type: "Ingredient", title: "Macaroni"), CollectionViewImage(type: "Ingredient", title: "Cheddar Cheese"), CollectionViewImage(type: "Ingredient", title: "Swiss Cheese"), CollectionViewImage(type: "Ingredient", title: "Parmesan Cheese"), CollectionViewImage(type: "Ingredient", title: "Mozarella"), CollectionViewImage(type: "Ingredient", title: "Italian Bread"), CollectionViewImage(type: "Ingredient", title: "Olive Oil")]
    
    func filterIngredients(_ input: String) -> [CollectionViewImage] {
        var filteredIngred : [CollectionViewImage] = []
        for image in ingredients {
            if(image.title.contains(input)) {
                filteredIngred.append(image)
            }
        }
        return filteredIngred
    }
    
    var body: some View {
        let filteredIngredients = (searchText != "") ? filterIngredients(searchText): ingredients
        CollectionView(images: filteredIngredients)
    }
}

