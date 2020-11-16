//
//  CollectionViewCell.swift
//  Pantry
//
//  Created by Yaniv Amiri on 10/12/20.
//
import SwiftUI

struct CollectionViewCell: View {
    let viewImage: CollectionViewImage
    let recipe : RecipeDetail?
    let API_KEY = "ddd9738101fa4e34bb503c2e6968f077"
    @State private var urlImage : UIImage?
    @Binding var activeIngredients : [String : String]
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func getRecipeIngredients() -> [Ingredient] {
        var ingreds =  recipe!.usedIngredients
        ingreds.append(contentsOf: recipe!.missedIngredients)
        return ingreds
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                urlImage = UIImage(data: data)
            }
        }
    }

    var body: some View {
    let returnContent = (viewImage.type == "Ingredient") ?
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
        : (recipe != nil) ? AnyView(NavigationLink(destination: AnyView(RecipeView(ingredients: getRecipeIngredients(), id: recipe!.id, activeIngredients: activeIngredients))) {
            Text(viewImage.name)
                .fontWeight(.semibold)
                .padding([.leading, .trailing, .bottom], 5)
                .frame(minWidth: 100, maxWidth: 150, minHeight: 100, maxHeight: 150)
        }.background(
        (urlImage != nil) ?
        Image(uiImage: urlImage!)
            .resizable()
            .frame(minWidth: 250, minHeight: 250)
            :
        Image("RSpaghetti")
        .resizable()
        .frame(minWidth: 250, minHeight: 250)
        ))
        :
        nil
        
        return returnContent.onAppear {
            let imageURL = viewImage.type == "Ingredient" && viewImage.image != "" ? URL(string: "https://spoonacular.com/cdn/ingredients_250x250/\(viewImage.image)")! : viewImage.image != "" ? URL(string: viewImage.image)! : nil
            imageURL != nil ? downloadImage(from: imageURL!): (urlImage = nil)
        }.onChange(of: viewImage.image, perform: { value in
            let imageURL = viewImage.type == "Ingredient" && value != "" ? URL(string: "https://spoonacular.com/cdn/ingredients_250x250/\(value)")! : value != "" ? URL(string: value)! : nil
            imageURL != nil ? downloadImage(from: imageURL!): (urlImage = nil)
        })
  }
}
