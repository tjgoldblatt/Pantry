//
//  CollectionViewCell.swift
//  Pantry
//
//  Created by Yaniv Amiri on 10/12/20.
//
import SwiftUI

struct CollectionViewCell: View {
  let viewImage: CollectionViewImage
  var body: some View {
      Text(viewImage.title)
        .fontWeight(.semibold)
        .padding([.leading, .trailing, .bottom], 5)
        .frame(minWidth: 100, maxWidth: 150, minHeight: 100, maxHeight: 150)
  }
}
