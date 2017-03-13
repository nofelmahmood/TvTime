//
//  SearchViewController.swift
//  TvTime
//
//  Created by Nofel Mahmood on 13/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tV = UITableView()
        tV.translatesAutoresizingMaskIntoConstraints = false
        
        return tV
    }()
    
    let searchItemsDataSource = SearchItemsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tabBarController?.tabBar.barTintColor = UIColor.black
        tabBarController?.tabBar.tintColor = Color.silver
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.tintColor = Color.silver
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Color.silver]
        
        let searchBar = UISearchBar()
        searchBar.delegate = self
        let searchBarTextField = searchBar.value(forKey: "searchField") as? UITextField
        searchBarTextField?.backgroundColor = UIColor.black
        searchBarTextField?.textColor = Color.silver
        searchBarTextField?.attributedPlaceholder = NSAttributedString(string: "Search Tv shows ...", attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
        navigationItem.titleView = searchBar
        
        view.addSubview(tableView)
        
        tableView.backgroundColor = UIColor.black
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: String(describing: ItemTableViewCell.self))
        
        tableView.pinLeadingToSuperview(margin: 8)
        tableView.pinTrailingToSuperview(margin: 8)
        tableView.pinTopToSuperview()
        tableView.pinBottomToSuperview(margin: 8)
        
        tableView.dataSource = searchItemsDataSource
        tableView.reloadData()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onScreenTap))
        view.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let searchBar = navigationItem.titleView
        let searchBarTextField = searchBar?.value(forKey: "searchField") as? UITextField
        searchBarTextField?.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let searchBar = navigationItem.titleView
        let searchBarTextField = searchBar?.value(forKey: "searchField") as? UITextField
        searchBarTextField?.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - User Interaction
    
    func onScreenTap() {
        
        let searchBar = navigationItem.titleView
        let textField = searchBar?.value(forKey: "searchField") as? UITextField
        textField?.resignFirstResponder()
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

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text else {
            return
        }
        
        searchItemsDataSource.prepare(query: text, page: 1)
            .then(execute: { (result) -> Void in
                self.tableView.reloadData()
        })
        searchBar.resignFirstResponder()
    }
}
