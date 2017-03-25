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

protocol TvShowDataSourceDelegate {
    func tvShowDataSource(dataSource: TvShowDataSource, didSelectEpisode: TraktEpisode)
    func tvShowDataSource(dataSource: TvShowDataSource, didSelectRelatedTvShow tvShow: TraktTvShow)
}

class TvShowDataSource: NSObject {

    var itemImage: UIImage?
    var tvShow: TraktTvShow?
    var imdbTvShow: IMDBTvShow?
    var seasons: [TraktSeason]?
    var credits: [Credit]?
    var relatedTvShows: [TraktTvShow]?
    
    var delegate: TvShowDataSourceDelegate?
    
    func prepare(selectedTvShow: TraktTvShow?, posterImage: UIImage?) -> AnyPromise {
        
        itemImage = posterImage
        tvShow = selectedTvShow
        
        let omdb = OMDB()
        let trakt = Trakt()
        
        let promise = Promise<Any>(resolvers: { resolve, reject in
            
            firstly(execute: {
                omdb.getTvShow(id: selectedTvShow!.imdbID!)
            }).then(execute: { result in
                self.imdbTvShow = result as! IMDBTvShow?
                
                return trakt.getSeasons(slug: self.tvShow!.slug)
            }).then(execute: { result in
                self.seasons = result as! [TraktSeason]?
                self.seasons = self.seasons?.sorted(by: { return $0.0.number < $0.1.number })
                
                return trakt.getRelatedTvShows(slug: selectedTvShow!.slug)
            
            }).then(execute: { (result) -> Void in
                self.relatedTvShows = result as? [TraktTvShow]
                
                resolve(result!)
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

// MARK: - UITableViewDataSource

extension TvShowDataSource: UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        
        guard let seasons = seasons else {
            return 1
        }
        
        return seasons.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 3
            
        } else {
            let season = seasons![section - 1]
            let episodes = season.episodes
            
            return episodes.count
        }
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
                
                let relatedShowsCell = tableView.dequeueReusableCell(withIdentifier: String(describing: TvShowRelatedShowsTableViewCell.self), for: indexPath) as! TvShowRelatedShowsTableViewCell
                
                relatedShowsCell.relatedItems = relatedTvShows
                relatedShowsCell.onRelatedTvShowButtonPress = { tvShow in
                    self.delegate?.tvShowDataSource(dataSource: self, didSelectRelatedTvShow: tvShow)
                }
                
                return relatedShowsCell
                
            case 2:
                
                let overviewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: TvShowOverviewTableViewCell.self), for: indexPath) as! TvShowOverviewTableViewCell

                overviewCell.overviewLabel.text = imdbTvShow?.plot
                
                return overviewCell
                
            default:
                break
            }
        }
        
        if indexPath.section > 0 {
            
            let season = seasons![indexPath.section - 1]
            let episode = season.episodes[indexPath.row]
            
            let episodeCell = tableView.dequeueReusableCell(withIdentifier: String(describing: TvShowEpisodeTableViewCell.self), for: indexPath) as! TvShowEpisodeTableViewCell
            episodeCell.setEpisode(episode: episode)
            
            return episodeCell
        }
    
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate 

extension TvShowDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
            
        case 0:
            return CGFloat.leastNonzeroMagnitude
        default:
            return 25
            
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard section != 0 else {
            return nil
        }
        
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: TvShowHeaderFooterView.self)) as! TvShowHeaderFooterView
        
        let season = seasons![section - 1]
        let number = season.number!
        
        view.setTitle(title: "Season \(number)")
        
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let season = seasons![indexPath.section - 1]
        let episode = season.episodes[indexPath.row]
        
        delegate?.tvShowDataSource(dataSource: self, didSelectEpisode: episode)
    }
}
