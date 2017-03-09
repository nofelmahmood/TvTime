//
//  PopularItemsDataSource.swift
//  TvTime
//
//  Created by Nofel Mahmood on 08/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit
import Alamofire
import PromiseKit
import AlamofireObjectMapper
import AlamofireImage

protocol DataSource {
    func dataSource(dataDidPrepare data: AnyObject?)
}

class FeedItemsDataSource: NSObject {
    
    var items: [TvShow]?
    
    func prepare() -> AnyPromise {
        
        let promise = Promise<Any>(resolvers: { resolve, reject in
            getPopularItems(page: 1).then(execute: { (result) -> Void in
                self.items = result as? [TvShow]
                resolve(result!)
            }).catch(execute: { error in
                reject(error)
            })
        })
        
        return AnyPromise(promise)
    }
    
    func getPopularItems(page: Int) -> AnyPromise {
        
        let urlString = "https://api.themoviedb.org/3/tv/popular?api_key=\(API.key)&language=en-US&page=\(page)"
        let url = URL(string: urlString)!
        
        let promise = Promise<[TvShow]>(resolvers: { resolve, reject in
            
            Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseArray(keyPath: "results", completionHandler: { (response: DataResponse<[TvShow]>) in
                
                if response.result.isSuccess {
                    resolve(response.result.value!)
                    
                } else {
                    reject(response.error!)
                }
                
            })
        })
        
        return AnyPromise(promise)
    }
}

extension FeedItemsDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items == nil ? 0: items!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ItemTableViewCell.self), for: indexPath) as! ItemTableViewCell
        
        let item = items![indexPath.row]
        let thumbnailURL = "\(APIEndPoint.image)\(item.thumbnailURL!)"
        print("Thumbnail URL String \(thumbnailURL)")
        let url = URL(string: thumbnailURL)
        let thumbnailRequest = URLRequest(url: url!)
        
        print("Thumbnail URL \(thumbnailURL)")
        
        cell.nameLabel.text = item.name
        cell.itemImageView.af_setImage(withURLRequest: thumbnailRequest)
        
        
        return cell
    }
}
