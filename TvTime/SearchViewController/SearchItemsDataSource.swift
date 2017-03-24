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
    
    var items: [TraktTvShow]?
    
    func prepare(query: String, page: Int) -> AnyPromise {
        
        
        Trakt.shared.authorize().then(execute: { result in
            print("Authorized \(result)")
        }).catch(execute: { error in
            print("Error in \(error)")
        })
        
        let stringQuery = query.replacingOccurrences(of: " ", with: "%20")
        let url = "\(APIEndPoint.search)?api_key=\(API.key)&language=en-US&query=\(stringQuery)&page=\(page)"
        
        let promise = Promise<[TraktTvShow]>(resolvers: { resolve, reject in
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
