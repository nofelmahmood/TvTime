//
//  FavoritesViewController.swift
//  TvTime
//
//  Created by Nofel Mahmood on 09/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tV = UITableView()
        tV.translatesAutoresizingMaskIntoConstraints = false
        
        return tV
    }()
    
    let favoritesItemsDataSource = FavoritesItemsDataSource()
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.black
        tabBarController?.tabBar.barTintColor = UIColor.black
        tabBarController?.tabBar.tintColor = Color.silver
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.tintColor = Color.silver
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Color.silver]
        tableView.backgroundColor = UIColor.black
        
        navigationItem.title = "Favorites"
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search ..."
        searchController.searchBar.backgroundColor = UIColor.black
        searchController.searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        tableView.tableHeaderView = searchController.searchBar
        
        view.addSubview(tableView)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.separatorStyle = .none
        
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: String(describing: ItemTableViewCell.self))
        
        tableView.pinEdgesToSuperview()
        
        favoritesItemsDataSource.prepare(items: nil)
        tableView.dataSource = favoritesItemsDataSource
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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

extension FavoritesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
