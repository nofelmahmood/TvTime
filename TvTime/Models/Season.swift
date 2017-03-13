//
//  Season.swift
//  TvTime
//
//  Created by Nofel Mahmood on 12/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit
import ObjectMapper

struct Season: Mappable {
    
    var episodeCount: Int!
    var airDate: String!
    var id: Int32!
    var thumbnailURL: String!
    var order: Int!
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        episodeCount <- map["episode_count"]
        airDate <- map["air_date"]
        id <- map["id"]
        thumbnailURL <- map["poster_path"]
        order <- map["season_number"]
        
    }
}
