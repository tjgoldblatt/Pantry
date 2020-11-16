//
//  RecipeView.swift
//  Pantry
//
//  Created by Yaniv Amiri on 10/11/20.
//

import SwiftUI

struct RecipeView: View {
    let ingredients : [Ingredient]
    @State private var inst: [Any] = []
    let id: Int
    let API_KEY = "ddd9738101fa4e34bb503c2e6968f077"
    @State private var instructions : [String: Any] = [:]
    let activeIngredients : [String : String]
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadInstructions(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                instructions = try! (JSONSerialization.jsonObject(with: data, options: []) as? [String:Any])!
                inst = instructions["analyzedInstructions"] as! [Any]
            }
        }
    }
    
    var body: some View {
        let instructionsView = ScrollView {
            ForEach(ingredients) { ingred in
                Text(ingred.name).background(activeIngredients.keys.contains(ingred.name) ? Color.yellow : Color.white)
            }
            ForEach(0..<inst.count) {index in
                let steps = inst[index] as! [String: Any]
                ForEach(0..<(steps["steps"] as! [Any]).count) { ind in
                    let step = (steps["steps"] as! [Any])[ind] as! [String: Any]
                    Text("Step \(step["number"] as! Int): \(step["step"] as! String)")
                }
            }
        }
        
        let noInstructionView = ScrollView {
            ForEach(ingredients) { ingred in
                Text(ingred.name).background(activeIngredients.keys.contains(ingred.name) ? Color.yellow : Color.white)
            }
            ForEach(0..<1) {_ in
                ForEach(0..<1) { _ -> Text in
                    guard let url = instructions["sourceUrl"] as? String else {
                        return Text("Error")
                    }
                    do {
                    return Text("Sorry this recipe does not have any instructions available, click this link to see recipe: \(url)")
                    }
                }
            }
        }
        
        VStack {
            (inst.count == 0) ? noInstructionView : instructionsView
        }.onAppear {
            let recipeIntructionsUrl = URL(string: "https://api.spoonacular.com/recipes/\(id)/information?apiKey=\(API_KEY)")!
            downloadInstructions(from: recipeIntructionsUrl)
        }
    }
}

struct AnalyzedInstruction: Decodable {
    var name: String
    var steps: [Step]
}

struct Step : Decodable {
    var number: Int
    var step: String
}
