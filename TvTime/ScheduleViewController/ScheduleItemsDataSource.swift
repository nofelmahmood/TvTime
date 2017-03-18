//
//  ScheduleItemsDataSource.swift
//  TvTime
//
//  Created by Nofel Mahmood on 13/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import PromiseKit

class ScheduleItemsDataSource: NSObject {
    
    var items: [TvMazeTvShow]?
    
    func prepare() -> AnyPromise {
        
        let promise = Promise<Any>(resolvers: { resolve, reject in
            
        })
        
        return AnyPromise(promise)
    }
}

extension ScheduleItemsDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items == nil ? 0: items!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ItemTableViewCell.self), for: indexPath) as! ItemTableViewCell
        
        let item = items![indexPath.row]
        
        cell.nameLabel.text = item.showName
        
        let imageURL = URL(string: item.imageURL)
        cell.itemImageView.image = nil
        cell.itemImageView.af_setImage(withURL: imageURL!)
        
        return cell
    }
}
