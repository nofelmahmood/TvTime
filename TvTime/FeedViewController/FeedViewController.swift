//
//  PopularViewController.swift
//  TvTime
//
//  Created by Nofel Mahmood on 08/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cV = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cV.translatesAutoresizingMaskIntoConstraints = false
        
        return cV
    }()
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let feedItemsDataSource = FeedItemsDataSource()
    
    var pushAnimator = PushAnimator()
    var popAnimator = PopAnimator()
    
    var selectedRowIndexPath: IndexPath!
    
    var tableViewThreshold: CGFloat = 200
    var loadingMore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.black
        tabBarController?.tabBar.barTintColor = UIColor.black
        tabBarController?.tabBar.tintColor = Color.silver
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.tintColor = Color.silver
        
        let segmentedControl = UISegmentedControl(items: feedItemsDataSource.segments)
        segmentedControl.tintColor = Color.silver
        segmentedControl.selectedSegmentIndex = 0
        navigationItem.titleView = segmentedControl
        
        segmentedControl.addTarget(self, action: #selector(onFeedItemsSegmentedControlValueChange), for: .valueChanged)
        
        view.addSubview(collectionView)
        
        collectionView.register(FeedItemCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: FeedItemCollectionViewCell.self))
        let collectionViewLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        collectionViewLayout.estimatedItemSize = CGSize(width: 40, height: 40)
        collectionViewLayout.minimumLineSpacing = 8
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        collectionView.dataSource = feedItemsDataSource
        collectionView.delegate = feedItemsDataSource
        collectionView.isPrefetchingEnabled = false
        
        collectionView.pinEdgesToSuperview(margin: 10)
        
        feedItemsDataSource.delegate = self
        
        view.addSubview(activityIndicatorView)
        
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.color = UIColor.white
        
        activityIndicatorView.centerVertically()
        activityIndicatorView.centerHorizontally()
        
        activityIndicatorView.startAnimating()
        collectionView.alpha = 0
        loadingMore = true
        
        feedItemsDataSource.prepare(forSegment: segmentedControl.selectedSegmentIndex)
            .then(execute: { (result) -> Void in
                
                self.collectionView.reloadData()
                self.activityIndicatorView.stopAnimating()
                self.loadingMore = false
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.collectionView.alpha = 1
                })
            })
        
 //       self.navigationController?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - User Interaction
    
    func onFeedItemsSegmentedControlValueChange(sender: UISegmentedControl) {
        
        activityIndicatorView.startAnimating()
        collectionView.alpha = 0
        
        let contentOffset = CGPoint(x: 0, y: 0)
        collectionView.setContentOffset(contentOffset, animated: false)
        loadingMore = true
        
        feedItemsDataSource.prepare(forSegment: sender.selectedSegmentIndex)
            .then(execute: { (result) -> Void in
                self.collectionView.reloadData()
                self.activityIndicatorView.stopAnimating()
                self.loadingMore = false
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.collectionView.alpha = 1
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
            self.collectionView.alpha = 0.6
            
        }, completion: { completed in
            UIView.animate(withDuration: 0.25, delay: 0.75, options: .curveEaseOut, animations: {
                
                self.collectionView.alpha = 1
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

extension FeedViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard !loadingMore else {
            return
        }
        
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - contentOffset <= tableViewThreshold {
            
            let segmentedControl = navigationItem.titleView as! UISegmentedControl
            loadingMore = true
            feedItemsDataSource.loadNextPage(forSegment: segmentedControl.selectedSegmentIndex)
                .then(execute: { (result) -> Void in
                    
                    self.loadingMore = false
                })
        }
        
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
    
    func feedItemsDataSource(dataSource: FeedItemsDataSource, didSelectTvShow tvShow: TraktTvShow, andImage image: UIImage?) {
        
        let tvshowViewController = TvShowViewController()
        tvshowViewController.itemImage = image
        tvshowViewController.tvShow = tvShow
        tvshowViewController.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(tvshowViewController, animated: true)
    }
}
