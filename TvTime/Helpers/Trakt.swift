//
//  Trakt.swift
//  TvTime
//
//  Created by Nofel Mahmood on 14/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import PromiseKit
import Moya

class Trakt {
    
    static let shared = Trakt()
    let limit = 200
    
    func authorize() -> AnyPromise {
        
        let url = "\(APIEndPoint.traktAuthorize)?response_type=code&client_id=\(API.traktClientID)&redirect_uri=\(API.redirectURI)"
        
        let headers = ["Content-Type": "application/json"]
        
        let promise = Promise<Any>(resolvers: { resolve, reject in
            
            Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON(completionHandler: { response in
                
                if response.result.isSuccess {
                    resolve(response.result.value!)
                } else {
                    reject(response.error!)
                }
            })
        })
        
        return AnyPromise(promise)
    }
    
    func getAccessToken() -> AnyPromise {
        
        let url = "\(APIEndPoint.traktToken)"
        let headers = ["Content-Type": "application/json"]
        
        let params = ["code": "wsrIWL7TCYfxaOGIuNgN", "client_id": API.traktClientID, "client_secret": API.traktClientSecret, "redirect_uri": API.redirectURI, "grant_type": "authorization_code"]
        
        let promise = Promise<Any>(resolvers: { resolve, reject in
            
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON(completionHandler: { response in
                
                if response.result.isSuccess {
                    resolve(response.result.value!)
                } else {
                    resolve(response.error!)
                }
            })
        })
        
        return AnyPromise(promise)
    }
    
    func provider() -> MoyaProvider<TraktService> {
        
        let endpointClosure = { (target: TraktService) -> Endpoint<TraktService> in
            let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
            let headers = ["Content-Type": "application/json", "trakt-api-version": "2", "trakt-api-key": API.traktClientID]
            
            return defaultEndpoint.adding(newHTTPHeaderFields: headers)
        }
        
        return MoyaProvider<TraktService>(endpointClosure: endpointClosure)
    }
    
    func getTvShows(showsType: String, page: Int) -> AnyPromise {
        
        var url = ""
        let headers = ["Content-Type": "application/json", "trakt-api-version": "2", "trakt-api-key": API.traktClientID]
        
        switch showsType {
        case TraktTvShowsType.popular:
            url = "\(APIEndPoint.traktPopular)"
            break
        case TraktTvShowsType.trending:
            url = "\(APIEndPoint.traktTrending)"
            break
        case TraktTvShowsType.anticipated:
            url = "\(APIEndPoint.traktAnticipated)"
            break
        default:
            break
        }
        
        url = "\(url)?extended=full&page=\(page)&limit=\(limit)"
        
        let provider = self.provider()
        
        let promise = Promise<[TraktTvShow]>(resolvers: { resolve, reject in
            provider.request(.tvShows(showsType: showsType, extendedInfo: "full", page: page, limit: limit), completion: { result in
                
                switch result {
                case let .success(moyaResponse):
                    let data = moyaResponse.data
                    let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0))
                    
                    if let json = json as? [[String: AnyObject]] {
                        
                        if showsType == TraktTvShowsType.trending || showsType == TraktTvShowsType.anticipated {
                            let showsJson = json.map({ $0["show"] as! [String: AnyObject] })
                            let tvShows = try? [TraktTvShow].decode(showsJson)
                            resolve(tvShows!)
                            
                        } else {
                            let tvShows = try? [TraktTvShow].decode(json)
                            resolve(tvShows!)
                        }
                        
                    } else {
                        let error = NSError(domain: "com.api.error", code: 0, userInfo: nil)
                        reject(error)
                    }
                    
                case let .failure(error):
                    reject(error)
                }
            })
        })
        
        return AnyPromise(promise)
    }
    
    
    func getSeasons(slug: String) -> AnyPromise {
        
        let provider = self.provider()
        
        let promise = Promise<[TraktSeason]>(resolvers: { resolve, reject in
            
            provider.request(.seasons(slug: slug, extendedInfo: "episodes"), completion: { result in
                
                switch result {
                case let .success(moyaResponse):
                    let data = moyaResponse.data
                    
                    let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as! [[String: AnyObject]]
                    if let json = json, let seasons = try? [TraktSeason].decode(json) {
                        resolve(seasons)
                    } else {
                        let error = NSError(domain: "com.api.error", code: 0, userInfo: nil)
                        reject(error)
                    }
                
                case let .failure(error):
                    reject(error)
                }
            })
        })
        
        return AnyPromise(promise)
    }
    
    func getEpisodeDetail(slug: String, seasonNumber: Int, episodeNumber: Int) -> AnyPromise {
        
        let provider = self.provider()
        
        let promise = Promise<TraktEpisodeDetail>(resolvers: { resolve, reject in
            
            provider.request(.episode(slug: slug, seasonNumber: seasonNumber, episodeNumber: episodeNumber, extendedInfo: "full"), completion: { result in
                
                switch result {
                case let .success(moyaResponse):
                    let data = moyaResponse.data
                    
                    let json = try? JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions(rawValue: 0))
                    if let json = json, let episodeDetail = try? TraktEpisodeDetail.decode(json) {
                        resolve(episodeDetail)
                    } else {
                        let error = NSError(domain: "com.api.error", code: 0, userInfo: nil)
                        reject(error)
                    }
                    
                case let .failure(error):
                    reject(error)
                }
            })
        })
        
        return AnyPromise(promise)
    }
    
    func getRelatedTvShows(slug: String) -> AnyPromise {
        
        let provider = self.provider()
        
        let promise = Promise<[TraktTvShow]>(resolvers: { resolve, reject in
            
            provider.request(.relatedTvShows(slug: slug, extendedInfo: "full"), completion: { result in
                
                switch result {
                case let .success(moyaResponse):
                    let data = moyaResponse.data
                    let json = try? JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.init(rawValue: 0))
                    if let json = json, let relatedTvShows = try? [TraktTvShow].decode(json) {
                        resolve(relatedTvShows)
                    } else {
                        let error = NSError(domain: "com.api.error", code: 0, userInfo: nil)
                        reject(error)
                    }
                case let .failure(error):
                    reject(error)
                }
            })
        })
        
        return AnyPromise(promise)
    }
    
    func getPosterURL(imdbID: String) -> AnyPromise {
        
        let promise = Promise<String>(resolvers: { resolve, reject in
            
            let omdb = OMDB()
            
            omdb.getTvShow(id: imdbID)
                .then(execute: { (result) -> Void in
                    let tvShow = result as! IMDBTvShow
                    resolve(tvShow.poster)
                    
                }).catch(execute: { error in
                    reject(error)
                })
        })
        
        return AnyPromise(promise)
    }
}
