//
//  TraktEpisodeDetail.swift
//  TvTime
//
//  Created by Nofel Mahmood on 20/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit
import Decodable

struct TraktEpisodeDetail: Decodable {
    
    let id: String!
    let season: Int!
    let number: Int!
    let title: String!
    let tvdbID: Int16?
    let imdbID: Int16?
    let tmdbID: Int16?
    let overview: String!
    let runtime: Int!
    
    static func decode(_ json: Any) throws -> TraktEpisodeDetail {
        
        return try TraktEpisodeDetail(
            id: json => "id",
            season: json => "season",
            number: json => "number",
            title: json => "title",
            tvdbID: json =>? "ids" =>? "tvdb",
            imdbID: json =>? "ids" =>? "imdb",
            tmdbID: json =>? "ids" =>? "tmdb",
            overview: json => "overview",
            runtime: json => "runtime"
        )
    }
}
