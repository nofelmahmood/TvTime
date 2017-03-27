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
    var imageURLs = [IndexPath: String]()
    
    func prepare(query: String, page: Int) -> AnyPromise {
        
        let trakt = Trakt()
        imageURLs.removeAll()
        
        let promise = Promise<[TraktTvShow]>(resolvers: { resolve, reject in
            
            trakt.searchTvShows(query: query)
                .then(execute: { (result) -> Void in
                    self.items = result as? [TraktTvShow]
                    resolve(self.items!)
                    
                }).catch(execute: { error in
                    reject(error)
                })
        })
        
        return AnyPromise(promise)
    }
    
    func clear() {
        items?.removeAll()
    }
    
    func itemAtIndexPath(indexPath: IndexPath) -> TraktTvShow? {
        guard let tvShows = items else {
            return nil
        }
        
        return tvShows[indexPath.row]
    }
}

// MARK: - UICollectionViewDataSource

extension SearchItemsDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items == nil ? 0: items!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FeedItemCollectionViewCell.self), for: indexPath) as! FeedItemCollectionViewCell
        
        let item = items![indexPath.row]
        cell.setTvShow(tvShow: item)
        cell.itemImageView.image = nil
        
        if imageURLs[indexPath] == nil {
            
            if let imdbID = item.imdbID {
                
                let trakt = Trakt()
                trakt.getPosterURL(imdbID: imdbID).then(execute: { (result) -> Void in
                    
                        let urlString = result as! String
                        let url = URL(string: urlString)!
                        self.imageURLs[indexPath] = urlString
                        
                        cell.itemImageView.af_setImage(withURL: url)
                    })
            }
            
        } else {
            
            let imageURL = imageURLs[indexPath]!
            let url = URL(string: imageURL)!
            cell.itemImageView.af_setImage(withURL: url)
        }
        
        return cell
    }
}
