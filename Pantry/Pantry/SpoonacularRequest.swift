//
//  SpoonacularAccessToken.swift
//  Pantry
//
//  Created by TJ Goldblatt on 10/16/20.
//

import Foundation

enum RecipeError:Error {
    case noDataAvailable
    case cannotProcessData
}


struct SpoonacularRequest {
    let resourceURL: URL
    let API_KEY = "ddd9738101fa4e34bb503c2e6968f077"
    
    init(ingredients:String, filters: [String], number: Int, limitLicense: Bool, ignorePantry: Bool){
        var filtersString = ""
        for filter in filters {
            filtersString += filters.last == filter ? filter + "," : filter
        }
        let resourceString = "https://api.spoonacular.com/recipes/complexSearch?includeIngredients=\(ingredients)\(filtersString == "" ? "" : "&cuisine=\(filtersString)")&number=\(number)&limitLicense=\(limitLicense)&ignorePantry=\(ignorePantry)&fillIngredients=true&addRecipeInformation=true&apiKey=\(API_KEY)"
        guard let resourceURL = URL(string: resourceString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func getRecipes(completion: @escaping(Result<[RecipeDetail], RecipeError>)-> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL){data, _ , _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do{
                let decoder = JSONDecoder()
                let recipeResponse = try decoder.decode(RecipeResponse.self, from: jsonData)
                
                completion(.success(recipeResponse.results != nil  ? recipeResponse.results! : []))
            } catch {
                completion(.failure(.cannotProcessData))
            }
        }
        dataTask.resume()
        
    }
}
