//
//  Credits.swift
//  TvTime
//
//  Created by Nofel Mahmood on 12/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit
import Decodable

struct Credit {
    
    let characterName: String!
    let creditID: String!
    let id: Int32!
    let name: String!
    let thumbnailURL: String!
    let order: Int32!
    
}

extension Credit: Decodable {
    
    static func decode(_ json: Any) throws -> Credit {
        
        return try Credit(
            characterName: json => "character",
            creditID: json => "credit_id",
            id: json => "id",
            name: json => "name",
            thumbnailURL: json => "profile_path",
            order: json => "order"
        )
    }
}
