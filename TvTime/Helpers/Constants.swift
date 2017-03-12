//
//  Constants.swift
//  TvTime
//
//  Created by Nofel Mahmood on 08/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import Foundation
import UIKit

struct API {
    static let key = "b29ef964cc3c10d59b806d3e0c1947b9"
}

struct APIEndPoint {
    static let newPopular = "http://api.tvmaze.com/shows"
    static let popular = "https://api.themoviedb.org/3/tv/popular"
    static let rated = "https://api.themoviedb.org/3/tv/top_rated"
    static let today = "https://api.themoviedb.org/3/tv/airing_today"
    static let externalIDs = "https://api.themoviedb.org/3/tv"
    static let credits = "https://api.themoviedb.org/3/tv/"
    static let image = "https://image.tmdb.org/t/p/w500"
    static let imdb = "http://www.omdbapi.com/"
}

struct Color {
    static let silver = UIColor(colorLiteralRed: 192/255, green: 192/255, blue: 192/255, alpha: 1)
}

struct Font {
    static let name = "Avenir-Light"
}
