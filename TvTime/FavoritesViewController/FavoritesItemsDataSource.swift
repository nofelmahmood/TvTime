//
//  FavoritesItemsDataSource.swift
//  TvTime
//
//  Created by Nofel Mahmood on 10/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit
import Alamofire
import PromiseKit
import AlamofireObjectMapper
import AlamofireImage

class FavoritesItemsDataSource: NSObject {

    var items: [TvShow]?
    
    func prepare(items: [TvShow]?) {
        self.items = items?.filter({ item in
            return item.favorite
        })
    }
}

extension FavoritesItemsDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items == nil ? 0: items!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ItemTableViewCell.self), for: indexPath) as! ItemTableViewCell
        
        let item = self.items![indexPath.row]
        
        cell.nameLabel.text = item.name
        
        return cell
    }
}
