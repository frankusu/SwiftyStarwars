//
//  File.swift
//  SwiftyStarwars
//
//  Created by Frank Su on 2020-01-25.
//  Copyright © 2020 frankusu. All rights reserved.
//

import Foundation

class Service {
    // Singleton
    static let shared = Service()
    
    func fetchData(completion: @escaping ([Film],Error?) -> () ) {
        let url = "https://swapi.co/api/films/"
        guard let swurl = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: swurl) {data,response,error in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            if let error = error {
                completion([],error)
                print("Error getting data", error)
            }
            
            guard let data = data else {return}
            do {
                let filmResults = try decoder.decode(Films.self, from: data)
                completion(filmResults.results,nil)
//                filmResults.results.forEach({
//                    print("Title: \($0.title) EpisodeId: \($0.episodeId)")
//                })
            } catch {
                print("Error decoding JSON", error)
                completion([],error)
            }
            
        }.resume()
    }
}
