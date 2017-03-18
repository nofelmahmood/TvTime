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

class Trakt {
    
    static let shared = Trakt()
    
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
        
        url = "\(url)?extended=full&page=\(page)&limit=20"
        
        let promise = Promise<[TraktTvShow]>(resolvers: { resolve, reject in
            Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON(completionHandler: { response in
                
                if response.result.isSuccess {
                    var json = response.result.value as! [[String: AnyObject]]
                    if showsType == TraktTvShowsType.trending || showsType == TraktTvShowsType.anticipated {
                        json = json.map({ $0["show"] as! [String: AnyObject] })
                    }
                    let tvShows = try? [TraktTvShow].decode(json)
                    resolve(tvShows!)
                    
                } else {
                    reject(response.error!)
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
