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
    func feedItemsDataSource(dataSource: FeedItemsDataSource, didSelectTvShow tvShow: TraktTvShow, andImage image: UIImage?)
}

class FeedItemsDataSource: NSObject {
    
    var segments = ["Popular", "Trending", "Anticipated"]
    var items: [TraktTvShow]?
    var page = 1
    var imageURLs = [IndexPath: String]()
    var favorited = [IndexPath]()
    
    var delegate: FeedItemsDataSourceDelegate?
    
    func prepare(forSegment segment: Int) -> AnyPromise {
        
        page = 1
        imageURLs = [IndexPath: String]()
        let promise = Promise<Any>(resolvers: { resolve, reject in
           
            var itemsPromise = Trakt.shared.getTvShows(showsType: TraktTvShowsType.popular, page: page)
            
            switch segment {
            case 1:
                itemsPromise = Trakt.shared.getTvShows(showsType: TraktTvShowsType.trending, page: page)
                break;
            case 2:
                itemsPromise = Trakt.shared.getTvShows(showsType: TraktTvShowsType.anticipated, page: page)
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
    
}

// MARK: - UITableViewDataSource

extension FeedItemsDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items == nil ? 0: items!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ItemTableViewCell.self), for: indexPath) as! ItemTableViewCell
        
        let item = items![indexPath.row]
        
        cell.setTvShow(tvShow: item, row: indexPath.row)
        cell.favorited = false
        
        cell.onFavorite = {
            
           // self.items![cell.tag].favorite = !item.favorite
           // item.favorite = !item.favorite
           // cell.favorited = item.favorite
            
          //  self.delegate?.feedItemsDataSource(dataSource: self, onFavorite: item.favorite)
        }
        
        guard let imdbID = item.imdbID else {
            return cell
        }
        
        if imageURLs[indexPath] == nil {
            cell.itemImageView.image = nil
            Trakt.shared.getPosterURL(imdbID: imdbID)
                .then(execute: { (result) -> Void in
                    
                    let urlString = result as! String
                    let url = URL(string: urlString)!
                    self.imageURLs[indexPath] = urlString

                    cell.itemImageView.af_setImage(withURL: url)
            })
        } else {
            
            cell.itemImageView.image = nil
            let imageURL = imageURLs[indexPath]!
            let url = URL(string: imageURL)!
            cell.itemImageView.af_setImage(withURL: url)

        }
        
        return cell
    }
}

// MARK: - UICollectionViewDataSource

extension FeedItemsDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items == nil ? 0: items!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FeedItemCollectionViewCell.self), for: indexPath) as! FeedItemCollectionViewCell
        
        let tvShow = items![indexPath.row]
        itemCell.setTvShow(tvShow: tvShow)
        
        itemCell.itemImageView.image = nil
        
        guard let imdbID = tvShow.imdbID else {
            return itemCell
        }
        
        if imageURLs[indexPath] == nil {
            Trakt.shared.getPosterURL(imdbID: imdbID)
                .then(execute: { (result) -> Void in
                    
                    let urlString = result as! String
                    let url = URL(string: urlString)!
                    self.imageURLs[indexPath] = urlString
                    
                    itemCell.itemImageView.af_setImage(withURL: url)
                })
        } else {
            
            let imageURL = imageURLs[indexPath]!
            let url = URL(string: imageURL)!
            itemCell.itemImageView.af_setImage(withURL: url)
            
        }
        
        return itemCell
    }
}

// MARK: - UICollectionViewDelegate 

extension FeedItemsDataSource: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tvShow = items![indexPath.row]
        let cell = collectionView.cellForItem(at: indexPath) as! FeedItemCollectionViewCell
        let image = cell.itemImageView.image
        
        delegate?.feedItemsDataSource(dataSource: self, didSelectTvShow: tvShow, andImage: image)
    }
    
}
