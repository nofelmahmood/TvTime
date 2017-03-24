//
//  IMDBTvShow.swift
//  TvTime
//
//  Created by Nofel Mahmood on 12/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit
import ObjectMapper
import Decodable

struct IMDBTvShow: Decodable {
    
    let rated: String!
    let released: String!
    let runtime: String!
    let writer: String!
    let year: String!
    let rating: String!
    let totalSeasons: String!
    let plot: String!
    let language: String!
    let genre: String!
    let director: String!
    let country: String!
    let awards: String!
    let poster: String!
    
    static func decode(_ json: Any) throws -> IMDBTvShow {
        
        return try IMDBTvShow(
            rated: json => "Rated",
            released: json => "Released",
            runtime: json => "Runtime",
            writer: json => "Writer",
            year: json => "Year",
            rating: json => "imdbRating",
            totalSeasons: json => "totalSeasons",
            plot: json => "Plot",
            language: json => "Language",
            genre: json => "Genre",
            director: json => "Director",
            country: json => "Country",
            awards: json => "Awards",
            poster: json => "Poster"
        )
    }
}
