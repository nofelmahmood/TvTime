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
    
    var pushAnimator = PushAnimator()
    var popAnimator = PopAnimator()
    
    var selectedRowIndexPath: IndexPath!
    
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
        
        //segmentedControl.translatesAutoresizingMaskIntoConstraints = false
      //  segmentedControl.leadingAnchor.constraint(equalTo: navigationController!.navigationBar.leadingAnchor, constant: 16.0).isActive = true
        //navigationController!.navigationBar.trailingAnchor.constraint(equalTo: segmentedControl.trailingAnchor, constant: 16.0).isActive = true
      
        view.addSubview(tableView)
        
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: String(describing: ItemTableViewCell.self))
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.separatorStyle = .none
        
        tableView.pinEdgesToSuperview()
        
        feedItemsDataSource.delegate = self
        tableView.dataSource = feedItemsDataSource
        tableView.delegate = self
        
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
        
        self.navigationController?.delegate = self
        
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
    
    // MARK: - Helpers
    
    func showFavoritedConfirmation(favorited: Bool) {
        
        let confirmationView = FavoriteConfirmationView()
        confirmationView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(confirmationView)
        
        confirmationView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        confirmationView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        confirmationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confirmationView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        confirmationView.setFavorite(favorite: favorited)
        
        confirmationView.alpha = 0
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            
            confirmationView.alpha = 1
            self.tableView.alpha = 0.6
            
        }, completion: { completed in
            UIView.animate(withDuration: 0.25, delay: 0.75, options: .curveEaseOut, animations: {
                
                self.tableView.alpha = 1
                confirmationView.alpha = 0
                
            }, completion: { completed in
                confirmationView.removeFromSuperview()
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

// MARK: - UITableViewDelegate 

extension FeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let tvShow = feedItemsDataSource.items![indexPath.row]
        let item = tableView.cellForRow(at: indexPath) as! ItemTableViewCell
        let image = item.itemImageView.image
        
        let tvShowViewController = TvShowViewController()
        tvShowViewController.itemImage = image
        tvShowViewController.tvShow = tvShow
        
        selectedRowIndexPath = indexPath
        
        navigationController?.pushViewController(tvShowViewController, animated: true)
    }
}

// MARK: - UINavigationControllerDelegate

extension FeedViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push {
            return self.pushAnimator
        } else if operation == .pop {
            return self.popAnimator
        }
        
        return nil
    }
}

// MARK: - FeedItemsDataSourceDelegate 

extension FeedViewController: FeedItemsDataSourceDelegate {
    
    func feedItemsDataSource(dataSource: FeedItemsDataSource, onFavorite favorite: Bool) {
        showFavoritedConfirmation(favorited: favorite)
    }
    
}
