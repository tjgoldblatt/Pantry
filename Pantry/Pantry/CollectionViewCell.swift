//
//  CollectionViewCell.swift
//  Pantry
//
//  Created by Yaniv Amiri on 10/12/20.
//
import SwiftUI

struct CollectionViewCell: View {
    let viewImage: CollectionViewImage
    let recipe : Recipe?
    @Binding var activeIngredients : [String : String]

    var body: some View {
    (viewImage.type == "Ingredient") ?
        AnyView(NavigationLink(destination: AnyView(AmountView(activeIngredients: $activeIngredients, activeIngredient: viewImage.title))) {
        Text(viewImage.title).fontWeight(.semibold).padding([.leading, .trailing, .bottom], 5).frame(minWidth: 100, maxWidth: 150, minHeight: 100, maxHeight: 150)
        })
        : (recipe != nil) ? AnyView(NavigationLink(destination: AnyView(RecipeView(ingredients: recipe!.ingredients, instructions: recipe!.instructions))) {
            Text(viewImage.title)
                .fontWeight(.semibold)
                .padding([.leading, .trailing, .bottom], 5)
                .frame(minWidth: 100, maxWidth: 150, minHeight: 100, maxHeight: 150)
        })
        :
        nil
  }
}
