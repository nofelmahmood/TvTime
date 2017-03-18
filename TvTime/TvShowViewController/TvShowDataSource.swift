//
//  TvShowDataSource.swift
//  TvTime
//
//  Created by Nofel Mahmood on 10/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import PromiseKit

class TvShowDataSource: NSObject {

    var itemImage: UIImage?
    var tvShow: TvShow?
    var imdbTvShow: IMDBTvShow?
    var seasons: [Season]?
    var credits: [Credit]?
    
    let numberOfSections = 3
    
    func prepare(selectedTvShow: TvShow?, posterImage: UIImage?) -> AnyPromise {
        
        itemImage = posterImage
        tvShow = selectedTvShow
        
        let promise = Promise<Any>(resolvers: { resolve, reject in
            
            firstly(execute: {
                getImdbInfo()
            }).then(execute: { result in
                self.imdbTvShow = result as! IMDBTvShow?
                return self.getSeasons()
            }).then(execute: { result in
                self.seasons = result as! [Season]?
                self.seasons = self.seasons?.sorted(by: { return $0.0.order < $0.1.order })
                return self.getCredits()
            }).then(execute: { (result) -> Void in
                self.credits = result as! [Credit]?
                resolve(result!)
            }).catch(execute: { error in
                reject(error)
            })
        })
        
        return AnyPromise(promise)
    }
    
    func getExternalIDs() -> AnyPromise {
        
        let id = tvShow!.id!
        let url = "\(APIEndPoint.externalIDs)/\(id)/external_ids?api_key=\(API.key)&language=en-US"
        
        let promise = Promise<Any>(resolvers: { resolve, reject in
            
            Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { response in
                if response.result.isSuccess {
                    resolve(response.result.value!)
                } else {
                    reject(response.error!)
                }
                
            })
        })
        
        return AnyPromise(promise)
    }
    
    func getImdbInfo() -> AnyPromise {
        
        let promise = Promise<IMDBTvShow>(resolvers: { resolve, reject in
            
            getExternalIDs().then(execute: { (result) -> Void in
                
                let json = result as! [String: Any]
                
                if let imdbID = json["imdb_id"] as? String {
                    let url = "\(APIEndPoint.imdb)?i=\(imdbID)"
                    
                    Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { response in
                        
                        if response.result.isSuccess {
                            let json = response.result.value as! [String: AnyObject]
                            let imdbData = try? IMDBTvShow.decode(json)
                            resolve(imdbData!)
                        } else {
                            reject(response.error!)
                        }
                    })
                    
                } else {
                    let error = NSError(domain: "com.api.error", code: 1041, userInfo: nil)
                    reject(error)
                }
                
            }).catch(execute: { error in
                reject(error)
            })
        })
        
        return AnyPromise(promise)
    }
    
    func getSeasons() -> AnyPromise {
        
        let id = tvShow!.id!
        let url = "\(APIEndPoint.tv)/\(id)?api_key=\(API.key)&language=en-US"
        
        let promise = Promise<[Season]>(resolvers: { resolve, reject in
            
            Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { response in
                
                if response.result.isSuccess {
                    
                    let json = response.result.value as! [String: AnyObject]
                    let jsonSeasons = json["seasons"]
                    let seasons = try? [Season].decode(jsonSeasons!)
                    resolve(seasons!)
                    
                } else {
                    reject(response.error!)
                }
            })
        })
        
        return AnyPromise(promise)
    }
    
    func getCredits() -> AnyPromise {
        
        let id = tvShow!.id!
        let url = "\(APIEndPoint.tv)/\(id)/credits?api_key=\(API.key)&language=en-US"
        
        let promise = Promise<[Credit]>(resolvers: { resolve, reject in
            
            Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { response in
                
                if response.result.isSuccess {
                    
                    let json = response.result.value as! [String: AnyObject]
                    let jsonCredits = json["cast"]
                    print("JSONCAST \(jsonCredits)")
                    let credits = try? [Credit].decode(jsonCredits!)
                    
                    resolve(credits!)
                } else {
                    reject(response.error!)
                }
            })
        })
        
        return AnyPromise(promise)
    }
    
}

extension TvShowDataSource: UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 2
        case 1:
            return credits == nil ? 0: credits!.count
        case 2:
            return seasons == nil ? 0: seasons!.count
        default:
            break
        }
        return 0
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            switch indexPath.row {
                
            case 0:
                
                let detailCell = tableView.dequeueReusableCell(withIdentifier: String(describing: TvShowDetailTableViewCell.self), for: indexPath) as! TvShowDetailTableViewCell
                
                detailCell.itemImageView.image = itemImage
                detailCell.setInfo(info: imdbTvShow)
                
                return detailCell
                
            case 1:
                
                let overviewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: TvShowOverviewTableViewCell.self), for: indexPath) as! TvShowOverviewTableViewCell
                
                overviewCell.overviewLabel.text = imdbTvShow?.plot
                //overviewCell.overviewLabel.text = tvShow?.overview
                
                return overviewCell
                
            default:
                break
            }
        }
        
        if indexPath.section == 1 {
            
            let credit = credits![indexPath.row]
            
            let creditCell = tableView.dequeueReusableCell(withIdentifier: String(describing: TvShowCreditTableViewCell.self), for: indexPath) as! TvShowCreditTableViewCell
            
            creditCell.setCredit(credit: credit)
            
            return creditCell
        }
        
        if indexPath.section == 2 {
            
            let season = seasons![indexPath.row]
            
            let seasonCell = tableView.dequeueReusableCell(withIdentifier: String(describing: TvShowSeasonTableViewCell.self), for: indexPath) as! TvShowSeasonTableViewCell
            
            seasonCell.setSeason(season: season)
            
            return seasonCell
        }
    
        return UITableViewCell()
    }
}
