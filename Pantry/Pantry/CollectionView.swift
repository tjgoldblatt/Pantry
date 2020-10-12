//
//  CollectionView.swift
//  Pantry
//
//  Created by Yaniv Amiri on 10/12/20.
//
import SwiftUI

struct CollectionView: View {
    @State var images = [CollectionViewImage]()
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ForEach(0..<images.count) { i in
                    ((i % 2) == 0) ?
                        HStack {
                            CollectionViewCell(viewImage: images[i])
                                .background(
                                    Image(uiImage: images[i].image)
                                    .resizable()
                                    .frame(minWidth: 200, minHeight: 200)
                            )
                            .cornerRadius(5)
                            .padding(10)
                            
                            CollectionViewCell(viewImage: images[i + 1])
                                .background(
                                    Image(uiImage: images[i + 1].image)
                                        .resizable()
                                        .frame(minWidth: 200, minHeight: 200)
                                )
                                .cornerRadius(5)
                                .padding(10)
                        }
                    : nil
                }
            }
        }
    }
}
