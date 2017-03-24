//
//  ScheduleViewController.swift
//  TvTime
//
//  Created by Nofel Mahmood on 09/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tV = UITableView()
        tV.translatesAutoresizingMaskIntoConstraints = false
        
        return tV
    }()
    
    let scheduleItemsDataSource = ScheduleItemsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tabBarController?.tabBar.barTintColor = UIColor.black
        tabBarController?.tabBar.tintColor = Color.silver
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.tintColor = Color.silver
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Color.silver]
        
        navigationItem.title = "Schedule"
        
        view.addSubview(tableView)
        
        tableView.pinLeadingToSuperview(margin: 8)
        tableView.pinTrailingToSuperview(margin: 8)
        tableView.pinBottomToSuperview(margin: 8)
        tableView.pinTopToSuperview()
        
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: String(describing: ItemTableViewCell.self))
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.backgroundColor = UIColor.black
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        tableView.dataSource = scheduleItemsDataSource
        tableView.reloadData()
        
        scheduleItemsDataSource.prepare().then(execute: { (result) -> Void in
            self.tableView.reloadData()
        })
        
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
