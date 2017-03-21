//
//  EpisodeDetailDataSource.swift
//  TvTime
//
//  Created by Nofel Mahmood on 20/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit
import Alamofire
import PromiseKit

class EpisodeDetailDataSource: NSObject {
    
    func prepare(slug: String, seasonNumber: Int, episodeNumber: Int) -> AnyPromise {
        
        let trakt = Trakt()
        
        return trakt.getEpisodeDetail(slug: slug, seasonNumber: seasonNumber, episodeNumber: episodeNumber)
    }
    
}

// MARK: - UITableViewDataSource

extension EpisodeDetailDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension EpisodeDetailDataSource: UITableViewDelegate {
    
}
