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

class OMDB {
    
    func getTvShow(id: String) -> AnyPromise {
        
        let url = "\(APIEndPoint.imdb)?i=\(id)"
        
        let promise = Promise<IMDBTvShow>(resolvers: { resolve, reject in
            
            Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { response in
                
                if response.result.isSuccess {
                    
                    let json = response.result.value as! [String: AnyObject]
                    let tvShow = try? IMDBTvShow.decode(json)
                    
                    if let tvShow = tvShow {
                        resolve(tvShow)
                    } else {
                        let error = NSError(domain: "com.error.notfound", code: 0, userInfo: nil)
                        reject(error)
                    }
                    
                } else {
                    reject(response.error!)
                }
            })
        })
        
        return AnyPromise(promise)
    }
}
