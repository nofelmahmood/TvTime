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
import Realm
import RealmSwift

protocol FeedItemsDataSourceDelegate {
    func feedItemsDataSource(dataSource: FeedItemsDataSource, onFavorite favorite: Bool)
}

class FeedItemsDataSource: NSObject {
    
    var segments = ["Popular", "Trending", "Anticipated"]
    var items: [TraktTvShow]?
    var page = 1
    var imageURLs = [IndexPath: String]()
    
    var delegate: FeedItemsDataSourceDelegate?
    
    func prepare(forSegment segment: Int) -> AnyPromise {
        
        let promise = Promise<Any>(resolvers: { resolve, reject in
           
            var itemsPromise = Trakt.shared.getTvShows(showsType: TraktTvShowsType.popular, page: 0)
            
            switch segment {
            case 1:
                itemsPromise = Trakt.shared.getTvShows(showsType: TraktTvShowsType.trending, page: 0)
                break;
            case 2:
                itemsPromise = Trakt.shared.getTvShows(showsType: TraktTvShowsType.anticipated, page: 0)
                break
            default:
                    break;
            }
            
            itemsPromise.then(execute: { (result) -> Void in
                self.items = result as? [TraktTvShow]
                resolve(result!)
            }).catch(execute: { error in
                reject(error)
            })
        })
        
        return AnyPromise(promise)
    }
    
    func loadNextPage(forSegment segment: Int) -> AnyPromise {
        
        let trakt = Trakt()
        page += 1
        
        let promise = Promise<Any>(resolvers: { resolve, reject in
            
            var itemsPromise = trakt.getTvShows(showsType: TraktTvShowsType.popular, page: page)
            
            switch segment {
            case 2:
                itemsPromise = trakt.getTvShows(showsType: TraktTvShowsType.trending, page: page)
                break
            case 3:
                itemsPromise = trakt.getTvShows(showsType: TraktTvShowsType.anticipated, page: page)
                break
            default:
                break
            }
            
            itemsPromise.then(execute: { (result) -> Void in
                self.items? += result as! [TraktTvShow]
                resolve(self.page)
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
 
    func getTraktPopularShows() -> AnyPromise {
        
        let url = "\(APIEndPoint.traktPopular)?extended=full"
        let headers = ["Content-Type": "application/json", "trakt-api-version": "2", "trakt-api-key": API.traktClientID]
        
        let promise = Promise<Any>(resolvers: { resolve, reject in
            
            Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON(completionHandler: { response in
                
                if response.result.isSuccess {
                    let json = response.result.value as! [[String: AnyObject]]
                    let tvShows = try? [TraktTvShow].decode(json)
                    print("Results are \(tvShows)")
                    print("JSON is \(json)")
                    resolve(json)
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
        
        var item = items![indexPath.row]
        
        cell.setTvShow(tvShow: item, row: indexPath.row)
        cell.favorited = false
        
        cell.onFavorite = {
           // self.items![cell.tag].favorite = !item.favorite
           // item.favorite = !item.favorite
           // cell.favorited = item.favorite
            
          //  self.delegate?.feedItemsDataSource(dataSource: self, onFavorite: item.favorite)
        }
        
        if imageURLs[indexPath] == nil {
            Trakt.shared.getPosterURL(imdbID: item.imdbID)
                .then(execute: { (result) -> Void in
                    cell.itemImageView.image = nil
                    
                    let urlString = result as! String
                    let url = URL(string: urlString)!
                    self.imageURLs[indexPath] = urlString
                    cell.itemImageView.af_setImage(withURL: url)
            })
        } else {
            
            let imageURL = imageURLs[indexPath]!
            let url = URL(string: imageURL)!
            cell.itemImageView.image = nil
            cell.itemImageView.af_setImage(withURL: url)
        }
        
        return cell
    }
}
