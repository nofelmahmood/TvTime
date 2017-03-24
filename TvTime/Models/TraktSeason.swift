//
//  TraktSeason.swift
//  TvTime
//
//  Created by Nofel Mahmood on 19/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit
import Decodable

struct TraktSeason: Decodable {
    
    let id: Int16!
    let number: Int!
    
    let episodes: [TraktEpisode]
    
    static func decode(_ json: Any) throws -> TraktSeason {
        
        return try TraktSeason(
            id: json => "ids" => "trakt",
            number: json => "number",
            episodes: json => "episodes"
        )
        
    }
}
