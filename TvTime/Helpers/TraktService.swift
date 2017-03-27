//
//  TraktService.swift
//  TvTime
//
//  Created by Nofel Mahmood on 22/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit
import Moya

enum TraktService {
    case tvShows(showsType: String, extendedInfo: String?, page: Int, limit: Int)
    case seasons(slug: String, extendedInfo: String)
    case episode(slug: String, seasonNumber: Int, episodeNumber: Int, extendedInfo: String)
    case relatedTvShows(slug: String, extendedInfo: String?)
    case searchTvShows(query: String, extendedInfo: String?)
}

extension TraktService: TargetType {
    var baseURL: URL {
        let string = "https://api.trakt.tv"
        
        return URL(string: string)!
    }
    
    var path: String {
        
        switch self {
            
        case .tvShows(let showsType, _, _, _):
            return "/shows/\(showsType)"
            
        case .seasons(let slug, _):
            return "/shows/\(slug)/seasons"
            
        case .episode(let slug, let seasonNumber, let episodeNumber, _):
            return "/shows/\(slug)/seasons/\(seasonNumber)/episodes/\(episodeNumber)"
            
        case .relatedTvShows(let slug, _):
            return "/shows/\(slug)/related"
            
        case .searchTvShows(_, _):
            return "/search/show"
            
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .tvShows, .seasons, .episode, .relatedTvShows, .searchTvShows:
            return .get
        default:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .tvShows(_, let extendedInfo, let page, let limit):
            guard let extendedInfo = extendedInfo else {
                return ["page": page, "limit": limit]
            }
            
            return ["page": page, "limit": limit, "extended": extendedInfo]
            
        case .seasons(_, let extendedInfo):
            return ["extended": extendedInfo]
            
        case .episode(_, _, _, let extendedInfo):
            return ["extended": extendedInfo]
            
        case .relatedTvShows(_, let extendedInfo):
            guard let extendedInfo = extendedInfo else {
                return nil
            }
            return ["extended": extendedInfo]
            
        case .searchTvShows(let query, let extendedInfo):
            guard let extendedInfo = extendedInfo else {
                return ["query": query]
            }
            return ["query": query, "extended": extendedInfo]
            
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
