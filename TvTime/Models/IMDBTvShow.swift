//
//  IMDBTvShow.swift
//  TvTime
//
//  Created by Nofel Mahmood on 12/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit
import ObjectMapper

struct IMDBTvShow: Mappable {
    
    var rated: String!
    var released: String!
    var runtime: String!
    var writer: String!
    var year: String!
    var rating: String!
    var totalSeasons: String!
    var plot: String!
    var language: String!
    var genre: String!
    var director: String!
    var country: String!
    var awards: String!
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        rated <- map["Rated"]
        released <- map["Released"]
        runtime <- map["Runtime"]
        writer <- map["Writer"]
        year <- map["Year"]
        rating <- map["imdbRating"]
        totalSeasons <- map["totalSeasons"]
        plot <- map["Plot"]
        language <- map["Language"]
        genre <- map["Genre"]
        director <- map["Director"]
        country <- map["Country"]
        awards <- map["Awards"]
    }
}
