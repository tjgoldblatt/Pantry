//
//  CollectionView.swift
//  Pantry
//
//  Created by Yaniv Amiri on 10/12/20.
//
import SwiftUI

struct CollectionView: View {
    var images = [CollectionViewImage]()
    
    func getCollectionViewCell(_ i : Int) -> some View {
        return CollectionViewCell(viewImage: images[i])
            .background(
                Image("ISpaghetti")
                .resizable()
                .frame(minWidth: 200, minHeight: 200)
        )
        .cornerRadius(5)
        .padding(10)
    }
    
    func hstackImages(_ i : Int) -> HStack<TupleView<(AnyView,AnyView)>> {
        return
            (((images.count % 2) != 0) && (i == (images.count - 1))) ?
                HStack{
                    AnyView(getCollectionViewCell(i))
                    AnyView(CollectionViewCell(viewImage: CollectionViewImage(type: "blank", title: "")))
                }
            :
            ((i % 2) == 0) ?
                HStack {
                    AnyView(
                        getCollectionViewCell(i))
                    AnyView(
                        getCollectionViewCell(i + 1))
                }
            :
                HStack{
                    AnyView(CollectionViewCell(viewImage: CollectionViewImage(type: "blank", title: "")))
                    AnyView(CollectionViewCell(viewImage: CollectionViewImage(type: "blank", title: "")))
            }
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ForEach(0..<images.count, id: \.self) { i in
                        hstackImages(i)
                }
            }
        }
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
