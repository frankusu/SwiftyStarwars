//
//  CharacterModel.swift
//  SwiftyStarwars
//
//  Created by Frank Su on 2020-01-26.
//  Copyright © 2020 frankusu. All rights reserved.
//

import Foundation

struct Characters : Decodable {
    let results : [Character]
}

struct Character : Decodable {
    let name : String
    let url : String
//    let homeworld : String
    
}

struct CharacterDetail : Decodable {
    let name : String
    let height : String
    let mass : String
    let hairColor : String
    let skinColor : String
    let birthYear : String
    let gender : String
}
