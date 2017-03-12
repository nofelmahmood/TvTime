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
    
    var animate: Bool!
    
    
    
    func prepare(selectedTvShow: TvShow?, posterImage: UIImage?) -> AnyPromise {
        
        itemImage = posterImage
        tvShow = selectedTvShow
        
        let promise = Promise<Any>(resolvers: { resolve, reject in
            
            getImdbInfo().then(execute: { (result) -> Void in
                print("Imdb info is \(result!)")
                self.imdbTvShow = result as! IMDBTvShow?
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
        
        print("URL is \(url)")
        
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
                let imdbID = json["imdb_id"] as! String
                let url = "\(APIEndPoint.imdb)?i=\(imdbID)"
                
                Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject(completionHandler: { (response: DataResponse<IMDBTvShow>) in
                    
                    if response.result.isSuccess {
                        resolve(response.result.value!)
                    } else {
                        reject(response.error!)
                    }
                })
                
            }).catch(execute: { error in
                reject(error)
            })
        })
        
        return AnyPromise(promise)
    }
}

extension TvShowDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
        
        return UITableViewCell()
    }
}
