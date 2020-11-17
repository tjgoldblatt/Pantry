//
//  RecipeView.swift
//  Pantry
//
//  Created by Yaniv Amiri on 10/11/20.
//

import SwiftUI
import UIKit

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}


struct RecipeView: View {
    let ingredients : [Ingredient]
    @State private var inst: [Any] = []
    let id: Int
    let API_KEY = "ddd9738101fa4e34bb503c2e6968f077"
    @State private var instructions : [String: Any] = [:]
    let image: Image

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
        VStack{
        let ingredientsView = ScrollView {
            ForEach(ingredients) { ingred in
                let capitalizedWord = ingred.name.capitalizingFirstLetter()
                Text(capitalizedWord).background(activeIngredients.keys.contains(ingred.name) ? Color.yellow : nil)
            }
        }.frame(width:400, height: 100, alignment: .center)
            
        let instructionsView = ScrollView {
            
            ForEach(0..<inst.count) {index in
                let steps = inst[index] as! [String: Any]
                ForEach(0..<(steps["steps"] as! [Any]).count) { ind in
                    let step = (steps["steps"] as! [Any])[ind] as! [String: Any]
                    let trimmed = step["step"] as! String
                   let secondTrim = trimmed.trimmingCharacters(in: .whitespacesAndNewlines)
                    Text("Step \(step["number"] as! Int): \(secondTrim)")
                        .frame(alignment: .topLeading)
                }
            }
        }.frame(width: 300, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        
        let noInstructionView = ScrollView {
            ForEach(0..<1) {_ in
                ForEach(0..<1) { _ -> AnyView in
                    guard let url = instructions["sourceUrl"] as? String else {
                        return AnyView(Text("Error"))
                    }
                    do {
                        return AnyView(Link("More Information", destination: URL(string: url)!))

                    }
                }
            }
        }
        
            ScrollView{
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
            image
                .cornerRadius(20)
            Spacer()
            ingredientsView
            Spacer()
            (inst.count == 0) ? AnyView(Text("No ingredients found, click link for more information")) : AnyView(instructionsView)
            Spacer()
            noInstructionView.font(.subheadline)
            
        }.onAppear {
            let recipeIntructionsUrl = URL(string: "https://api.spoonacular.com/recipes/\(id)/information?apiKey=\(API_KEY)")!
            downloadInstructions(from: recipeIntructionsUrl)
            }
        }
        }.background(Color.white)
        
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
