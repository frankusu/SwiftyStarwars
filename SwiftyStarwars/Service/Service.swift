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
            } catch {
                print("Error decoding JSON", error)
                completion([],error)
            }
        }.resume()
    }
    
//    func fetchCharacters(characters : [String], completion: @escaping (Character?,Error?) -> () ) {
    func fetchCharacters(characters : [String]) {
        // how do i know my dispatch group is working ?
        let dispatchGroup = DispatchGroup()
        var characterArray = [String]()
        for urlString in characters {
            guard let characterUrl = URL(string: urlString) else {return}
            dispatchGroup.enter()
            URLSession.shared.dataTask(with: characterUrl) { data, response, error in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let error = error {
                    print(error)
                    return
                }
                guard let data = data else {return}
                do {
                    let character = try decoder.decode(Character.self, from: data)
                    print(character.name)
                    characterArray.append(character.name)
                } catch {
                    print("Error decoding JSON", error)
                }
            }.resume()
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            print("Completed dispatch group actions, printing character names...")
            characterArray.forEach({print("\($0) bruh")})
            
        }
    }
}
