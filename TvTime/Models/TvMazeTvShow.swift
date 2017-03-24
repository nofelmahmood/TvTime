//
//  TvMazeTvShow.swift
//  TvTime
//
//  Created by Nofel Mahmood on 14/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit
import Decodable

struct TvMazeTvShow: Decodable {
    
    let id: Int64!
    let url: String!
    let name: String!
    let showName: String!
    let season: Int!
    var number: Int!
    var airDate: String!
    var runtime: Int!
    var network: String!
    var imageURL: String!
    var summary: String!
    
    static func decode(_ json: Any) throws -> TvMazeTvShow {
        
        return try TvMazeTvShow(
            id: json => "id",
            url: json => "url",
            name: json => "name",
            showName: json => "show.name",
            season: json => "season",
            number: json => "number",
            airDate: json => "airdate",
            runtime: json => "runtime",
            network: json => "show.network.name",
            imageURL: json => "show.image.original",
            summary: json => "show.summary"
        )
    }
}
