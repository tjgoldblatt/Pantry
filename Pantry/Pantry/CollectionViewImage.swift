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
    var type: String
    var title: String
}

struct CollectionViewImage_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
