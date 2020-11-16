//
//  CollectionView.swift
//  Pantry
//
//  Created by Yaniv Amiri on 10/12/20.
//
import SwiftUI

struct CollectionView: View {
    @State private var images : [CollectionViewImage] = []
    var searchText : String?
    @State private var ingredients: [AutocompleteDetail] = []
    @State private var recipes : [RecipeDetail] = []
    @Binding var activeIngredients : [String: String]
    
    func setFilteredIngreds() -> [CollectionViewImage] {
        var filtered = [CollectionViewImage]()
        for recipe in self.recipes {
            filtered.append(CollectionViewImage(name: recipe.title, image: recipe.image, id: recipe.title.hashValue, aisle: "", possibleUnits: [], type: "Recipe"))
        }
        return filtered
    }
    
    func getRecipes(_ inputIngredients: String) {
        let request = SpoonacularRequest(ingredients: inputIngredients, number: 10, limitLicense: false, ranking: 1, ignorePantry: true)
        
        request.getRecipes{ result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let results):
                recipes = results
                images = setFilteredIngreds()
            }
        }
    }
    
    func getIngredients(_ input: String) {
        let request = AutocompleteRequest(query: input, number: 25, metaInformation: true, intolerances: true)
        request.autocompleteResults{ result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let results):
                self.ingredients = results
                images = (searchText != "") ? autocompleteNames(searchText!) : autocompleteNames("a")
            }
        }
    }
    
    func autocompleteNames(_ input: String) -> [CollectionViewImage] {
        // Loops through autocompleteDetail objects, appending each name to a final list
        var resultCVIs : [CollectionViewImage] = []
        for ingred in self.ingredients {
            let newCVI = CollectionViewImage(name: ingred.name, image: ingred.image, id: ingred.id, aisle: ingred.aisle, possibleUnits: ingred.possibleUnits, type: "Ingredient")
            resultCVIs.append(newCVI)
        }
        return resultCVIs
    }
    
    func getCollectionViewCell(_ i : Int) -> some View {
        let cell = CollectionViewCell(viewImage: images[i], recipe: recipes.count != 0 ? recipes[i] : nil, activeIngredients: $activeIngredients)
        .cornerRadius(5)
        .padding(10)
        return activeIngredients.keys.contains(images[i].name) ? AnyView(cell.overlay(RoundedRectangle(cornerRadius: 5)                            .stroke(Color.green, lineWidth: 4))) : AnyView(cell);
    }
    
    func hstackImages(_ i : Int) -> HStack<TupleView<(AnyView,AnyView)>> {
        return
            (((images.count % 2) != 0) && (i == (images.count - 1))) ?
                HStack{
                    AnyView(getCollectionViewCell(i))
                    AnyView(CollectionViewCell(viewImage: CollectionViewImage(name: "", image: "", id: -i, aisle: "", possibleUnits: [], type: ""), recipe: nil, activeIngredients: $activeIngredients))
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
                    AnyView(CollectionViewCell(viewImage: CollectionViewImage(name: "", image: "", id: -i, aisle: "", possibleUnits: [], type: ""), recipe: nil, activeIngredients: $activeIngredients))
                    AnyView(CollectionViewCell(viewImage: CollectionViewImage(name: "", image: "", id: -i - 1, aisle: "", possibleUnits: [], type: ""), recipe: nil, activeIngredients: $activeIngredients))
            }
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ForEach(0..<images.count, id: \.self) { i in
                        hstackImages(i)
                }
            }.onAppear {
                if(searchText != nil) {
                    getIngredients(searchText != "" ? searchText! : "a")
                }
                else {
                    var inputIngredients = ""
                    if(activeIngredients.count != 0){
                        for key in activeIngredients.keys {
                            inputIngredients += (key == activeIngredients.first?.key) ? key.lowercased() : ",+ \(key.lowercased())"
                        }
                    }
                    getRecipes(inputIngredients)
                }
                
            }.onChange(of: searchText, perform: { value in
                if(value != nil && value != "") {
                    getIngredients(value!)
                    images = autocompleteNames(value!)
                }
            })
        }
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
