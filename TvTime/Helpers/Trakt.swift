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
        
        print("URL is \(url)")
        
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
}
