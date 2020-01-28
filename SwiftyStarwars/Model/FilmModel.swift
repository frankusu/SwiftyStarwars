//
//  FilmModel.swift
//  SwiftyStarwars
//
//  Created by Frank Su on 2020-01-25.
//  Copyright © 2020 frankusu. All rights reserved.
//

import Foundation

struct Films : Decodable {
    let results : [Film]
}

struct Film : Decodable {
    let title : String
    let episodeId : Int
//    let openingCrawl : String
    let director : String
    let producer : String
    let releaseDate : String
    let characters,planets,starships,vehicles,species : [String]
    
}
