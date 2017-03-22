//
//  TraktEpisode.swift
//  TvTime
//
//  Created by Nofel Mahmood on 19/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit
import Decodable

struct TraktEpisode: Decodable {
    
    let number: Int!
    let id: Int16!
    let title: String!
    let tvdbID: Int16?
    let imdbID: String?
    let tmdbID: Int16?
    
    static func decode(_ json: Any) throws -> TraktEpisode {
        
        return try TraktEpisode(
            number: json => "number",
            id: json => "ids" => "trakt",
            title: json => "title",
            tvdbID: json =>? "ids" =>? "tvdb",
            imdbID: json =>? "ids" =>? "imdb",
            tmdbID: json =>? "ids" =>? "tmdb"
        )
    }
}
