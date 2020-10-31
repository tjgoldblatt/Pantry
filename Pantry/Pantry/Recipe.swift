//
//  Recipe.swift
//  Pantry
//
//  Created by Yaniv Amiri on 10/13/20.
//

import SwiftUI

struct Recipe: Identifiable, Hashable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.title == rhs.title
    }
    
    var id : String {
        title
    }
    var title: String
    var image: String
    var missedIngredientCount: Int
}
