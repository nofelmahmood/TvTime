//
//  TvShowViewController.swift
//  TvTime
//
//  Created by Nofel Mahmood on 10/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit

class TvShowViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tV = UITableView()
        tV.translatesAutoresizingMaskIntoConstraints = false
        
        return tV
    }()
    
    lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var itemImage: UIImage?
    var tvShow: TraktTvShow?
    
    let tvShowDataSource = TvShowDataSource()
    
    var firstTime = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.black
        tableView.backgroundColor = UIColor.black
        tabBarController?.tabBar.barTintColor = UIColor.black
        tabBarController?.tabBar.tintColor = Color.silver
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.tintColor = Color.silver
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Color.silver]
        tableView.backgroundColor = UIColor.black
        
        itemImageView.image = itemImage
        
        view.addSubview(tableView)
        
        tableView.pinLeadingToSuperview(margin: 8)
        tableView.pinTrailingToSuperview(margin: 8)
        tableView.pinTopToSuperview()
        tableView.pinBottomToSuperview(margin: 8)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 25
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        tableView.register(TvShowHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: String(describing: TvShowHeaderFooterView.self))
        tableView.register(TvShowDetailTableViewCell.self, forCellReuseIdentifier: String(describing: TvShowDetailTableViewCell.self))
        tableView.register(TvShowRelatedShowsTableViewCell.self, forCellReuseIdentifier: String(describing: TvShowRelatedShowsTableViewCell.self))
        tableView.register(TvShowOverviewTableViewCell.self, forCellReuseIdentifier: String(describing: TvShowOverviewTableViewCell.self))
        tableView.register(TvShowCreditTableViewCell.self, forCellReuseIdentifier: String(describing: TvShowCreditTableViewCell.self))
        tableView.register(TvShowSeasonTableViewCell.self, forCellReuseIdentifier: String(describing: TvShowSeasonTableViewCell.self))
        tableView.register(TvShowEpisodeTableViewCell.self, forCellReuseIdentifier: String(describing: TvShowEpisodeTableViewCell.self))
        
        tableView.dataSource = tvShowDataSource
        tableView.delegate = tvShowDataSource
        
        tvShowDataSource.delegate = self
        
        tvShowDataSource.prepare(selectedTvShow: tvShow, posterImage: itemImage).always {
            self.tableView.reloadData()
        }
        
        navigationItem.title = tvShow?.title
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TvShowViewController: TvShowDataSourceDelegate {
    
    func tvShowDataSource(dataSource: TvShowDataSource, didSelectEpisode: TraktEpisode) {
        
    }
    
    func tvShowDataSource(dataSource: TvShowDataSource, didSelectRelatedTvShow tvShow: TraktTvShow) {
        
        let tvShowViewController = TvShowViewController()
        tvShowViewController.tvShow = tvShow
        tvShowViewController.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(tvShowViewController, animated: true)
    }
}
