//
//  Credits.swift
//  TvTime
//
//  Created by Nofel Mahmood on 12/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit
import ObjectMapper

struct Credit: Mappable {
 
    var characterName: String!
    var creditID: String!
    var id: Int32!
    var name: String!
    var thumbnailURL: String!
    var order: Int!

    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        characterName <- map["character"]
        creditID <- map["credit_id"]
        id <- map["id"]
        name <- map["name"]
        thumbnailURL <- map["profile_path"]
        order <- map["order"]
    }
}
