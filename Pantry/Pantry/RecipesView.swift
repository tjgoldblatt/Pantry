//
//  RecipesView.swift
//  Pantry
//
//  Created by Yaniv Amiri on 10/11/20.
//

import SwiftUI

struct RecipesView: View {
    
    @Binding var inputFilters : [String]
    @Binding var inputIngredients : [String : String]
    
    var body: some View {
        return CollectionView(inputFilters: $inputFilters, activeIngredients: $inputIngredients)
    }
}
