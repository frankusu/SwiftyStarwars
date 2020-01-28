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
        fetchGenericData(urlString: url, completion: completion)
    }
    
    func fetchPlanet(url : String, completion: @escaping (Planet?,Error?) -> () ) {
        fetchGenericData(urlString: url, completion: completion)
    }
    
    func fetchStarship(url : String, completion: @escaping (Starship?,Error?) -> () ) {
        fetchGenericData(urlString: url, completion: completion)
    }
    
    func fetchVehicle(url : String, completion: @escaping (Vehicle?,Error?) -> () ) {
        fetchGenericData(urlString: url, completion: completion)
    }
    
    func fetchSpecie(url : String, completion: @escaping (Specie?,Error?) -> () ) {
        fetchGenericData(urlString: url, completion: completion)
    }
    
    func fetchGenericData<T : Decodable>(urlString : String, completion: @escaping (T?, Error?) -> () ){
        guard let url = URL(string: urlString) else {return}
        print("T is of type", T.self)
        URLSession.shared.dataTask(with: url) {data,response,error in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            if let error = error {
                completion(nil,error)
                print("Error getting data", error)
                return
            }
            guard let data = data else {return}
            do {
                let result = try decoder.decode(T.self, from: data)
                completion(result,nil)
            } catch {
                print("Error decoding JSON", error)
                completion(nil,error)
                return
            }
        }.resume()
    }

}
