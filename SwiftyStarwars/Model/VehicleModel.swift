//
//  VehicleModel.swift
//  SwiftyStarwars
//
//  Created by Frank Su on 2020-01-26.
//  Copyright © 2020 frankusu. All rights reserved.
//

import Foundation

struct Vehicle : Decodable {
    let name : String
    let url : String
}

struct VehicleDetail : Decodable {
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
    let vehicleClass : String
}
