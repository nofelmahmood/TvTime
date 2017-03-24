//
//  Season.swift
//  TvTime
//
//  Created by Nofel Mahmood on 12/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit
import Decodable

struct Season {
    
    let episodeCount: Int!
    let airDate: String!
    let id: Int32!
    let thumbnailURL: String!
    let order: Int!
}

extension Season: Decodable {
    
    static func decode(_ json: Any) throws -> Season {
        
        return try Season(
            episodeCount: json => "episode_count",
            airDate: json => "air_date",
            id: json => "id",
            thumbnailURL: json => "poster_path",
            order: json => "season_number"
        )
    }
}
