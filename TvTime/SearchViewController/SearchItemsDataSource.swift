//
//  SearchItemsDataSource.swift
//  TvTime
//
//  Created by Nofel Mahmood on 13/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit
import Alamofire
import PromiseKit

class SearchItemsDataSource: NSObject {
    
    var items: [TvShow]?
    
    func prepare(query: String, page: Int) -> AnyPromise {
        
        let stringQuery = query.replacingOccurrences(of: " ", with: "%20")
        let url = "\(APIEndPoint.search)?api_key=\(API.key)&language=en-US&query=\(stringQuery)&page=\(page)"
        
        let promise = Promise<[TvShow]>(resolvers: { resolve, reject in
            Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseArray(keyPath: "results", completionHandler: { (response: DataResponse<[TvShow]>) in
                
                if response.result.isSuccess {
                    self.items = response.result.value
                    resolve(response.result.value!)
                
                } else {
                    reject(response.error!)
                }
            })
        })
        
        return AnyPromise(promise)
    }
    
    func clear() {
        items = nil
    }
}

extension SearchItemsDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items == nil ? 0: items!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ItemTableViewCell.self), for: indexPath) as! ItemTableViewCell
        
        let item = items![indexPath.row]
        cell.setTvShow(tvShow: item, row: indexPath.row)
        
        return cell
    }
}
