//
//  CollectionViewImage.swift
//  Pantry
//
//  Created by Yaniv Amiri on 10/12/20.
//

import SwiftUI

struct CollectionViewImage: Identifiable, Hashable {
    var id: String {
        title
    }
    var image: UIImage
    var type: String
    var title: String
}
