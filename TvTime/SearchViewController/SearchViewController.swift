//
//  SearchViewController.swift
//  TvTime
//
//  Created by Nofel Mahmood on 13/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    lazy var screenTapGestureRecognizer: UITapGestureRecognizer = {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onScreenTap))
        
        return tapGestureRecognizer
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
        
        view.addSubview(collectionView)
        
        collectionView.pinEdgesToSuperview(margin: 8)
        collectionView.register(FeedItemCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: FeedItemCollectionViewCell.self))
        
        let collectionViewLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        collectionViewLayout.estimatedItemSize = CGSize(width: 40, height: 40)
        collectionViewLayout.minimumLineSpacing = 8
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        collectionView.dataSource = searchItemsDataSource
        collectionView.delegate = self
        collectionView.isPrefetchingEnabled = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //let searchBar = navigationItem.titleView
        //let searchBarTextField = searchBar?.value(forKey: "searchField") as? UITextField
        //searchBarTextField?.text = ""
        
        //searchItemsDataSource.clear()
        //collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       // let searchBar = navigationItem.titleView
       // let searchBarTextField = searchBar?.value(forKey: "searchField") as? UITextField
       // searchBarTextField?.becomeFirstResponder()
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

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        view.addGestureRecognizer(screenTapGestureRecognizer)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.removeGestureRecognizer(screenTapGestureRecognizer)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text else {
            return
        }
        
        searchItemsDataSource.prepare(query: text, page: 1)
            .then(execute: { (result) -> Void in
                self.collectionView.reloadData()
        })
        searchBar.resignFirstResponder()
    }
}

// MARK: - UICollectionViewDelegate

extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let tvShow = searchItemsDataSource.itemAtIndexPath(indexPath: indexPath) else {
            return
        }
        
        let tvShowViewController = TvShowViewController()
        tvShowViewController.tvShow = tvShow
        
        navigationController?.pushViewController(tvShowViewController, animated: true)
    }
}
