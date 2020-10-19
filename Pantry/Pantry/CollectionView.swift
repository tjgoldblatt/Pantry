//
//  CollectionView.swift
//  Pantry
//
//  Created by Yaniv Amiri on 10/12/20.
//
import SwiftUI

struct CollectionView: View {
    var images = [CollectionViewImage]()
    var recipes : [Recipe]?
    @Binding var activeIngredients : [String: String]
    
    func getCollectionViewCell(_ i : Int) -> some View {
        let cell = CollectionViewCell(viewImage: images[i], recipe: recipes != nil ? recipes![i] : nil, activeIngredients: $activeIngredients)
            .background(
                Image((images[i].type == "Ingredient") ? "ISpaghetti" : "RSpaghetti")
                .resizable()
                .frame(minWidth: 200, minHeight: 200)
        )
        .cornerRadius(5)
        .padding(10)
        return activeIngredients.keys.contains(images[i].title) ? AnyView(cell.overlay(RoundedRectangle(cornerRadius: 5)                            .stroke(Color.green, lineWidth: 4))) : AnyView(cell);
    }
    
    func hstackImages(_ i : Int) -> HStack<TupleView<(AnyView,AnyView)>> {
        return
            (((images.count % 2) != 0) && (i == (images.count - 1))) ?
                HStack{
                    AnyView(getCollectionViewCell(i))
                    AnyView(CollectionViewCell(viewImage: CollectionViewImage(type: "blank", title: ""), recipe: nil, activeIngredients: $activeIngredients))
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
                    AnyView(CollectionViewCell(viewImage: CollectionViewImage(type: "blank", title: ""), recipe: nil, activeIngredients: $activeIngredients))
                    AnyView(CollectionViewCell(viewImage: CollectionViewImage(type: "blank", title: ""), recipe: nil, activeIngredients: $activeIngredients))
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
