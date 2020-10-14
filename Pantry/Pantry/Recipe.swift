//
//  Recipe.swift
//  Pantry
//
//  Created by Yaniv Amiri on 10/13/20.
//

import SwiftUI

struct Recipe: Identifiable, Hashable {
    var id: String {
        image.id
    }
    var image: CollectionViewImage
    var ingredients: [String: String]
    var instructions: String
}
