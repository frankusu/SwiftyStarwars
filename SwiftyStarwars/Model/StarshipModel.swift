//
//  StarshipModel.swift
//  SwiftyStarwars
//
//  Created by Frank Su on 2020-01-26.
//  Copyright © 2020 frankusu. All rights reserved.
//

import Foundation

struct Starships : Decodable {
    let results : [Starship]
}

struct Starship : Decodable {
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
    let startshipClass : String?
    
}
//"name": "Executor",
//"model": "Executor-class star dreadnought",
//"manufacturer": "Kuat Drive Yards, Fondor Shipyards",
//"cost_in_credits": "1143350000",
//"length": "19000",
//"max_atmosphering_speed": "n/a",
//"crew": "279144",
//"passengers": "38000",
//"cargo_capacity": "250000000",
//"consumables": "6 years",
//"hyperdrive_rating": "2.0",
//"MGLT": "40",
//"starship_class": "Star dreadnought",
//"pilots": [],
