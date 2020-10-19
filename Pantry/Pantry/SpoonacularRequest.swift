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
    
    init(ingredients:String, number: Int, limitLicense: Bool, ranking: Int, ignorePantry: Bool){
        let resourceString = "https://api.spoonacular.com/recipes/findByIngredients?ingredients=\(ingredients)&number=\(number)&limitLicense=\(limitLicense)&ranking=\(ranking)&ignorePantry=\(ignorePantry)&apiKey=\(API_KEY)"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func getRecipes(completion: @escaping(Result<[RecipeDetail], RecipeError>)-> Void) {
        let defaultSession = URLSession(configuration: .default)
        let dataTask = defaultSession.dataTask(with: resourceURL){data, _ , _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do{
                let decoder = JSONDecoder()
                let recipeResponse = try decoder.decode(RecipeResponse.self, from: jsonData)
                let recipeDetails = recipeResponse.response
                completion(.success(recipeDetails))
            } catch {
                completion(.failure(.cannotProcessData))
            }
        }
        
    }
}