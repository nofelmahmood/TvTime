//
//  OMDBService.swift
//  TvTime
//
//  Created by Nofel Mahmood on 26/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit
import Moya

enum OMDBService {
    case tvShow(id: String)
}

extension OMDBService: TargetType {
    var baseURL: URL {
        let string = "http://www.omdbapi.com"
        
        return URL(string: string)!
    }
    
    var path: String {
        
        switch self {
            
        case .tvShow(_):
            return ""
        default:
            return ""
            
        }
    }
    
    var method: Moya.Method {
        
        switch self {
            
        }
    }
    
    var parameters: [String: AnyObject] {
        
    }
}
