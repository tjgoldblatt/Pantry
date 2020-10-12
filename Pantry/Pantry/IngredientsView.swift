//
//  IngredientsView.swift
//  Pantry
//
//  Created by Yaniv Amiri on 10/11/20.
//

import SwiftUI

struct IngredientsView: View {
    @State private var searchText = "Search"
    let ingredients : [CollectionViewImage] = [CollectionViewImage(image: UIImage(named: "ISpaghetti")!, type: "Ingredient", title: "Thin Spaghetti"), CollectionViewImage(image: UIImage(named: "ISpaghetti")!, type: "Ingredient", title: "Angel Hair"), CollectionViewImage(image: UIImage(named: "ISpaghetti")!, type: "Ingredient", title: "Linguini"), CollectionViewImage(image: UIImage(named: "ISpaghetti")!, type: "Ingredient", title: "Garlic"), CollectionViewImage(image: UIImage(named: "ISpaghetti")!, type: "Ingredient", title: "Tomato"), CollectionViewImage(image: UIImage(named: "ISpaghetti")!, type: "Ingredient", title: "Salt"), CollectionViewImage(image: UIImage(named: "ISpaghetti")!, type: "Ingredient", title: "Onion"), CollectionViewImage(image: UIImage(named: "ISpaghetti")!, type: "Ingredient", title: "Thyme"), CollectionViewImage(image: UIImage(named: "ISpaghetti")!, type: "Ingredient", title: "Oregano"), CollectionViewImage(image: UIImage(named: "ISpaghetti")!, type: "Ingredient", title: "Parsley"), CollectionViewImage(image: UIImage(named: "ISpaghetti")!, type: "Ingredient", title: "Course Black Pepper"), CollectionViewImage(image: UIImage(named: "ISpaghetti")!, type: "Ingredient", title: "Bread Crumbs"), CollectionViewImage(image: UIImage(named: "ISpaghetti")!, type: "Ingredient", title: "Ground Beef"), CollectionViewImage(image: UIImage(named: "ISpaghetti")!, type: "Ingredient", title: "Red Chili Flakes"), CollectionViewImage(image: UIImage(named: "ISpaghetti")!, type: "Ingredient", title: "Pasta Shells"), CollectionViewImage(image: UIImage(named: "ISpaghetti")!, type: "Ingredient", title: "Macaroni"), CollectionViewImage(image: UIImage(named: "ISpaghetti")!, type: "Ingredient", title: "Cheddar Cheese"), CollectionViewImage(image: UIImage(named: "ISpaghetti")!, type: "Ingredient", title: "Swiss Cheese"), CollectionViewImage(image: UIImage(named: "ISpaghetti")!, type: "Ingredient", title: "Parmesan Cheese"), CollectionViewImage(image: UIImage(named: "ISpaghetti")!, type: "Ingredient", title: "Mozarella"), CollectionViewImage(image: UIImage(named: "ISpaghetti")!, type: "Ingredient", title: "Italian Bread"), CollectionViewImage(image: UIImage(named: "ISpaghetti")!, type: "Ingredient", title: "Olive Oil")]
    
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
            CollectionView(images: ingredients)
        }
        
    }
}

struct IngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsView()
    }
}
