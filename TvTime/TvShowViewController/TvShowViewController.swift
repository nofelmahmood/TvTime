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
    var tvShow: TvShow?
    
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
        
        tableView.pinTopToSuperview()
        tableView.pinLeadingToSuperview(margin: 8)
        tableView.pinTrailingToSuperview(margin: 8)
        tableView.pinBottomToSuperview(margin: 8)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 25
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        tableView.register(TvShowCastHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: TvShowCastHeaderView.self))
        tableView.register(TvShowDetailTableViewCell.self, forCellReuseIdentifier: String(describing: TvShowDetailTableViewCell.self))
        tableView.register(TvShowOverviewTableViewCell.self, forCellReuseIdentifier: String(describing: TvShowOverviewTableViewCell.self))
        tableView.register(TvShowCreditTableViewCell.self, forCellReuseIdentifier: String(describing: TvShowCreditTableViewCell.self))
        tableView.register(TvShowSeasonTableViewCell.self, forCellReuseIdentifier: String(describing: TvShowSeasonTableViewCell.self))
        
        tableView.dataSource = tvShowDataSource
        tableView.delegate = self
        
        tvShowDataSource.prepare(selectedTvShow: tvShow, posterImage: itemImage).then(execute: { (result) -> Void in
            self.tableView.reloadData()
        })
        
        navigationItem.title = tvShow?.name
        
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

extension TvShowViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
            
        case 0:
            return CGFloat.leastNonzeroMagnitude
        default:
            return 25
            
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 1:
            
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: TvShowCastHeaderView.self))
            
            return view
        case 2:
            
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: TvShowCastHeaderView.self))
            
            return view
        default:
            break
        }

        
        return nil
    }
}
