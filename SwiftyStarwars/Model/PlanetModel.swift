//
//  PlanetModel.swift
//  SwiftyStarwars
//
//  Created by Frank Su on 2020-01-26.
//  Copyright © 2020 frankusu. All rights reserved.
//

import Foundation

struct Planet : Decodable {
    let name : String
    let url : String
}

struct PlanetDetail : Decodable {
    let name : String
    let rotationPeriod : String
    let orbitalPeriod : String
    let diameter : String
    let climate : String
    let gravity : String
    let terrain : String
    let surfaceWater : String
    let population : String
    
    var dict : [String:String] {
        let dict : [String:String] = [
            "name" : name,
            "rotationPeriod" : rotationPeriod,
            "orbitalPeriod" : orbitalPeriod,
            "diameter" : diameter,
            "climate" : climate,
            "gravity" : gravity,
            "terrain" : terrain,
            "surfaceWater" : surfaceWater,
            "population" : population
            
        ]
        
        return dict
    }
}

