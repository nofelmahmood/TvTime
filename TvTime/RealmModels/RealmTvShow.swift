//
//  RealmTvShow.swift
//  TvTime
//
//  Created by Nofel Mahmood on 10/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class RealmTvShow: Object {
    
    dynamic var country: String!
    dynamic var id: NSNumber!
    dynamic var popularity: NSNumber!
    dynamic var thumbnailURL: String!
    dynamic var backdropURL: String!
    dynamic var name: String!
    dynamic var originalName: String!
    dynamic var overview: String!
    dynamic var favorite: Bool
    
    required init() {
        
        id = 0
        popularity = 0
        thumbnailURL = ""
        backdropURL = ""
        name = ""
        overview = ""
        favorite = false
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        self.favorite = false
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        self.favorite = false
        super.init(value: value, schema: schema)
    }
    
    func fillProps(withAPIModel model: TvShow) {
        
        country = model.country
        id = model.id as NSNumber
        popularity = model.popularity as NSNumber
        thumbnailURL = model.thumbnailURL
        backdropURL = model.backdropURL
        name = model.name
        originalName = model.originalName
        overview = model.overview
        favorite = model.favorite
    }
    
}
