//
//  TvShow.swift
//  TvTime
//
//  Created by Nofel Mahmood on 08/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit
import ObjectMapper

struct TvShow: Mappable {
    
    var country: String!
    var id: Int32!
    var popularity: Int32!
    var thumbnailURL: String!
    var backdropURL: String!
    var name: String!
    var originalName: String!
    var overview: String!
    var favorite = false
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        country <- map["country"]
        id <- map["id"]
        popularity <- map["popularity"]
        thumbnailURL <- map["poster_path"]
        backdropURL <- map["backdrop_path"]
        name <- map["name"]
        originalName <- map["original_name"]
        overview <- map["overview"]
    }
}


