//
//  TraktTvShow.swift
//  TvTime
//
//  Created by Nofel Mahmood on 17/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit
import Decodable

struct TraktTvShow: Decodable {
    
    let id: Int16!
    let language: String!
    let rating: Int!
    let overview: String!
    let status: String!
    let airDay: String!
    let airTime: String!
    let airTimezone: String!
    let title: String!
    let network: String!
    let trailer: String!
    let imdbID: String!
    let tmdbID: Int16!
    let tvdbID: Int16!
    let slug: String!
    let country: String!
    let genres: [String]!

    static func decode(_ json: Any) throws -> TraktTvShow {
        
        return try TraktTvShow(
            id: json => "ids" => "trakt",
            language: json => "language",
            rating: json => "rating",
            overview: json => "overview",
            status: json => "status",
            airDay: json => "airs" => "day",
            airTime: json => "airs" => "time",
            airTimezone: json => "airs" => "timezone",
            title: json => "title",
            network: json => "network",
            trailer: json => "trailer",
            imdbID: json => "ids" => "imdb",
            tmdbID: json => "ids" => "tmdb",
            tvdbID: json => "ids" => "tvdb",
            slug: json => "ids" => "slug",
            country: json => "country",
            genres: json => "genres"
        )
    }
}
