//
//  StarshipModel.swift
//  SwiftyStarwars
//
//  Created by Frank Su on 2020-01-26.
//  Copyright © 2020 frankusu. All rights reserved.
//

import Foundation

struct Starship : Decodable {
    let name : String
    let url : String
    
}

struct StarshipDetail : Decodable {
    let name : String
    let model : String
    let manufacturer : String
    let costInCredits : String
    let length : String
    let maxAtmospheringSpeed : String
    let crew : String
    let passengers : String
    let cargoCapacity : String
    let consumables : String
    let hyperdriveRating : String
    let MGLT : String
//    let startshipClass : String?
    
    var dict : [String:String] {
        let dict : [String:String] = [
            "name" : name,
            "model" : model,
            "manufacturer" : manufacturer,
            "costInCredits" : costInCredits,
            "length" : length,
            "maxAtmospheringSpeed" : maxAtmospheringSpeed,
            "crew" : crew,
            "passengers" : passengers,
            "cargoCapacity" : cargoCapacity,
            "consumables" : consumables,
            "hyperdriveRating" : hyperdriveRating,
            "MGLT" : MGLT,
//            "startshipClass" : startshipClass ?? "No ship class"
        ]
        
        return dict
    }
}
