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
    let height : String
    let mass : String
    let hairColor : String
    let skinColor : String
    let birthYear : String
    let gender : String
//    let homeworld : String
    
}

//"name": "Luke Skywalker",
//"height": "172",
//"mass": "77",
//"hair_color": "blond",
//"skin_color": "fair",
//"eye_color": "blue",
//"birth_year": "19BBY",
//"gender": "male",
//"homeworld": "https://swapi.co/api/planets/1/"
