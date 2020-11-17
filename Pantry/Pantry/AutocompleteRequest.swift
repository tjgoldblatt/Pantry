//
//  AutocompleteRequest.swift
//  Pantry
//
//  Created by Ronnie Arbo on 10/26/20.
//
import Foundation

enum ACError:Error {
    case noDataAvailable
    case cannotProcessData
}

struct AutocompleteDetail:Decodable{
    var name: String
    var image: String
    var id: Int
    var aisle: String
    var possibleUnits: [String]
}


struct AutocompleteRequest {
    let resourceURL: URL
    let API_KEY = "ddd9738101fa4e34bb503c2e6968f077"
    
    init(query: String, number: Int, metaInformation: Bool, intolerances: Bool){
        // Query: The partial or full ingredient name
        // Number: The number of results to return
        // metaInformation: Whether to return more meta information about the ingredients
        // Potential intolerances found at https://spoonacular.com/food-api/docs#Intolerances
        let resourceString = "https://api.spoonacular.com/food/ingredients/autocomplete?query=\(query)&number=\(number)&metaInformation=\(metaInformation)&intolerances=\(intolerances)&apiKey=\(API_KEY)"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
    
    func autocompleteResults(completion: @escaping(Result<[AutocompleteDetail], ACError>)-> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL){data, _ , _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do{
                let decoder = JSONDecoder()
                let autocompleteResponse = try decoder.decode(Array<AutocompleteDetail>.self, from: jsonData)
                
                completion(.success(autocompleteResponse))
            } catch {
                completion(.failure(.cannotProcessData))
            }
        }
        dataTask.resume()
        
    }
}
