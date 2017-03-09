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
    
    let feedItemsDataSource = FeedItemsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.black
        tableView.backgroundColor = UIColor.black
        tabBarController?.tabBar.barTintColor = UIColor.black
        tabBarController?.tabBar.tintColor = Color.silver
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.tintColor = Color.silver
        
        let segmentedControl = UISegmentedControl(items: feedItemsDataSource.segments)
        segmentedControl.tintColor = Color.silver
        segmentedControl.selectedSegmentIndex = 0
        navigationItem.titleView = segmentedControl
        
        segmentedControl.addTarget(self, action: #selector(onFeedItemsSegmentedControlValueChange), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.leadingAnchor.constraint(equalTo: navigationController!.navigationBar.leadingAnchor, constant: 16.0).isActive = true
        navigationController!.navigationBar.trailingAnchor.constraint(equalTo: segmentedControl.trailingAnchor, constant: 16.0).isActive = true
        
        view.addSubview(tableView)
        
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: String(describing: ItemTableViewCell.self))
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        
        tableView.pinEdgesToSuperview()
        
        tableView.dataSource = feedItemsDataSource
        
        feedItemsDataSource.prepare(forSegment: segmentedControl.selectedSegmentIndex)
            .then(execute: { result in
                self.tableView.reloadData()
            })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - User Interaction
    
    func onFeedItemsSegmentedControlValueChange(sender: UISegmentedControl) {
        
        feedItemsDataSource.prepare(forSegment: sender.selectedSegmentIndex)
            .then(execute: { (result) -> Void in
                self.tableView.reloadData()
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
