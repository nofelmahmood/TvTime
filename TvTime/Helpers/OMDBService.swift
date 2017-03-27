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
        case .tvShow(_):
            return .get
        default:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .tvShow(let id):
            return ["i": id]
        default:
            return nil
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
    }
    
    var sampleData: Data {
        switch self {
        default:
            return Data(base64Encoded: "{ \"name\": \"WestWorld\"}")!
        }
    }
    
    var task: Task {
        switch self {
        default:
            return .request
        }
    }
    
}
