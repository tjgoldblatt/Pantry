//
//  IngredientsView.swift
//  Pantry
//
//  Created by Yaniv Amiri on 10/11/20.
//

import SwiftUI

struct IngredientsView: View {
    let searchText: String
    @Binding var activeFilters : [String]
    @Binding var activeIngredients : [String : String]
    var body: some View {
        return CollectionView(searchText: searchText, inputFilters: $activeFilters, activeIngredients: $activeIngredients)
    }
}


struct IngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
