//
//  OMDB.swift
//  TvTime
//
//  Created by Nofel Mahmood on 18/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit
import Alamofire
import PromiseKit
import Moya

class OMDB {
    
    func provider() -> MoyaProvider<OMDBService> {
        
        let endpointClosure = { (target: OMDBService) -> Endpoint<OMDBService> in
            let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
            let headers = ["Content-Type": "application/json", "trakt-api-version": "2", "trakt-api-key": API.traktClientID]
            
            return defaultEndpoint.adding(newHTTPHeaderFields: headers)
        }
        
        return MoyaProvider<OMDBService>(endpointClosure: endpointClosure)
    }
    
    func getTvShow(id: String) -> AnyPromise {
        
        let provider = self.provider()
        
        let promise = Promise<IMDBTvShow>(resolvers: { resolve, reject in
            
            provider.request(.tvShow(id: id), completion: { result in
                switch result {
                case let .success(moyaResponse):
                    let data = moyaResponse.data
                    let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as! [String: AnyObject]
                    
                    if let json = json, let tvShow = try? IMDBTvShow.decode(json) {
                        resolve(tvShow)
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
}
