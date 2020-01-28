//
//  SpeciesModel.swift
//  SwiftyStarwars
//
//  Created by Frank Su on 2020-01-26.
//  Copyright © 2020 frankusu. All rights reserved.
//

import Foundation

struct Species : Decodable {
    let results : [Specie]
}

// Technically species is singular and plural but compiler...
struct Specie : Decodable {
    let name : String
    let url : String
}

struct SpecieDetail : Decodable {
    let name : String
    let classification : String
    let designation : String
    let averageHeight : String
    let skinColors : String
    let hairColors : String
    let eyeColors : String
    let averageLifespan : String
    let homeworld : String?
    let language : String
}
