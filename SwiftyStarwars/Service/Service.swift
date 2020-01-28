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
    
    func fetchCharacter(url : String, completion: @escaping (Character?,Error?) -> () ) {
        guard let charurl = URL(string: url) else {return}
        URLSession.shared.dataTask(with: charurl) {data,response,error in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            if let error = error {
                completion(nil,error)
                print("Error getting data", error)
                return
            }
            guard let data = data else {return}
            do {
                let character = try decoder.decode(Character.self, from: data)
                completion(character,nil)
            } catch {
                print("Error decoding JSON", error)
                completion(nil,error)
                return
            }
        }.resume()
    }
    
    func fetchPlanet(url : String, completion: @escaping (Planet?,Error?) -> () ) {
        guard let rurl = URL(string: url) else {return}
        URLSession.shared.dataTask(with: rurl) {data,response,error in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            if let error = error {
                completion(nil,error)
                print("Error getting data", error)
                return
            }
            guard let data = data else {return}
            do {
                let result = try decoder.decode(Planet.self, from: data)
                completion(result,nil)
            } catch {
                print("Error decoding JSON", error)
                completion(nil,error)
                return
            }
        }.resume()
    }

}
