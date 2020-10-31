//
//  CollectionViewCell.swift
//  Pantry
//
//  Created by Yaniv Amiri on 10/12/20.
//
import SwiftUI

struct CollectionViewCell: View {
    let viewImage: CollectionViewImage
    let recipe : Recipe?
    @State private var urlImage : UIImage?
    @Binding var activeIngredients : [String : String]
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print(url)
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                urlImage = UIImage(data: data)
            }
        }
    }

    var body: some View {
        let imageURL = URL(string: "https://spoonacular.com/cdn/ingredients_250x250/\(viewImage.image)")!
        downloadImage(from: imageURL)
        
    return (viewImage.type == "Ingredient") ?
        AnyView(NavigationLink(destination: AnyView(AmountView(activeIngredients: $activeIngredients, activeIngredient: viewImage.name))) {
        Text(viewImage.name).fontWeight(.semibold).padding([.leading, .trailing, .bottom], 5).frame(minWidth: 100, maxWidth: 150, minHeight: 100, maxHeight: 150)
        }.background(
            (urlImage != nil) ?
            Image(uiImage: urlImage!)
                .resizable()
                .frame(minWidth: 250, minHeight: 250)
                :
            Image("ISpaghetti")
            .resizable()
            .frame(minWidth: 250, minHeight: 250)
        ))
        : (recipe != nil) ? AnyView(Text("")) /*AnyView(NavigationLink(destination: AnyView(RecipeView(ingredients: recipe!.ingredients, instructions: recipe!.instructions, activeIngredients: activeIngredients))) {
            Text(viewImage.name)
                .fontWeight(.semibold)
                .padding([.leading, .trailing, .bottom], 5)
                .frame(minWidth: 100, maxWidth: 150, minHeight: 100, maxHeight: 150)
        })*/
        :
        nil
  }
}
