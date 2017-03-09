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
    static let popular = "https://api.themoviedb.org/3/tv/popular?api_key=b29ef964cc3c10d59b806d3e0c1947b9&language=en-US&page=1"
    static let image = "https://image.tmdb.org/t/p/w500"
}

struct Color {
    static let silver = UIColor(colorLiteralRed: 192/255, green: 192/255, blue: 192/255, alpha: 1)
}
