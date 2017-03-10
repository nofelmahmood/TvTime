//
//  PopularViewController.swift
//  TvTime
//
//  Created by Nofel Mahmood on 08/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tV = UITableView()
        tV.translatesAutoresizingMaskIntoConstraints = false
        
        return tV
    }()
    
    lazy var tableViewActivityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        
        return activityIndicatorView
    }()
    
    let feedItemsDataSource = FeedItemsDataSource()
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.black
        tableView.backgroundColor = UIColor.black
        tabBarController?.tabBar.barTintColor = UIColor.black
        tabBarController?.tabBar.tintColor = Color.silver
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.tintColor = Color.silver
        tableView.backgroundColor = UIColor.black
        
        let segmentedControl = UISegmentedControl(items: feedItemsDataSource.segments)
        segmentedControl.tintColor = Color.silver
        segmentedControl.selectedSegmentIndex = 0
        navigationItem.titleView = segmentedControl
        
        segmentedControl.addTarget(self, action: #selector(onFeedItemsSegmentedControlValueChange), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.leadingAnchor.constraint(equalTo: navigationController!.navigationBar.leadingAnchor, constant: 16.0).isActive = true
        navigationController!.navigationBar.trailingAnchor.constraint(equalTo: segmentedControl.trailingAnchor, constant: 16.0).isActive = true
      
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search ..."
        searchController.searchBar.backgroundColor = UIColor.black
        searchController.searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
        tableView.tableHeaderView = searchController.searchBar
        
        view.addSubview(tableView)
        
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: String(describing: ItemTableViewCell.self))
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.separatorStyle = .none
        
        tableView.pinEdgesToSuperview()
        
        tableView.dataSource = feedItemsDataSource
        
        view.addSubview(tableViewActivityIndicatorView)
        
        tableViewActivityIndicatorView.hidesWhenStopped = true
        tableViewActivityIndicatorView.color = UIColor.white
        
        tableViewActivityIndicatorView.centerVertically()
        tableViewActivityIndicatorView.centerHorizontally()
        
        tableViewActivityIndicatorView.startAnimating()
        tableView.alpha = 0
        feedItemsDataSource.prepare(forSegment: segmentedControl.selectedSegmentIndex)
            .then(execute: { (result) -> Void in
                self.tableView.reloadData()
                self.tableViewActivityIndicatorView.stopAnimating()
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.tableView.alpha = 1
                })
            })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - User Interaction
    
    func onFeedItemsSegmentedControlValueChange(sender: UISegmentedControl) {
        
        tableViewActivityIndicatorView.startAnimating()
        tableView.alpha = 0
        feedItemsDataSource.prepare(forSegment: sender.selectedSegmentIndex)
            .then(execute: { (result) -> Void in
                self.tableView.reloadData()
                self.tableViewActivityIndicatorView.stopAnimating()
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.tableView.alpha = 1
                })
            })
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

// MARK: - UISearchResultsUpdating

extension FeedViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
