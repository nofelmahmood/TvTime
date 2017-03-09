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
    
    var segments = ["Popular", "Rated", "Today"]
    var items: [TvShow]?
    
    func prepare(forSegment segment: Int) -> AnyPromise {
        
        let promise = Promise<Any>(resolvers: { resolve, reject in
           
            var itemsPromise = getPopularItems(page: 1)
            
            switch segment {
            case 1:
                itemsPromise = getRatedItems(page: 1)
                break;
            case 2:
                itemsPromise = getTodayItems(page: 1)
                break;
            default:
                    break;
            }
            
            itemsPromise.then(execute: { (result) -> Void in
                self.items = result as? [TvShow]
                resolve(result!)
            }).catch(execute: { error in
                reject(error)
            })
        })
        
        return AnyPromise(promise)
    }
    
    func getPopularItems(page: Int) -> AnyPromise {
        
        let urlString = "\(APIEndPoint.popular)?api_key=\(API.key)&language=en-US&page=\(page)"
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
    
    
    func getRatedItems(page: Int) -> AnyPromise {
        
        let urlString = "\(APIEndPoint.rated)?api_key=\(API.key)&language=en-US&page=\(page)"
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
    
    func getTodayItems(page: Int) -> AnyPromise {
        
        let urlString = "\(APIEndPoint.today)?api_key=\(API.key)&language=en-US&page=\(page)"
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
        
        cell.nameLabel.text = item.name
        
        guard let thumbnailURL = item.thumbnailURL else {
            cell.itemImageView.image = nil
            return cell
        }
        
        let thumbnailFullURL = "\(APIEndPoint.image)\(thumbnailURL)"
        let url = URL(string: thumbnailFullURL)
        let thumbnailRequest = URLRequest(url: url!)
        cell.itemImageView.image = nil
        cell.itemImageView.af_setImage(withURLRequest: thumbnailRequest)
        
        
        return cell
    }
}
