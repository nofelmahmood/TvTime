//
//  TvShowRelatedShowsTableViewCell.swift
//  TvTime
//
//  Created by Nofel Mahmood on 21/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit

class TvShowRelatedShowsTableViewCell: UITableViewCell {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cV = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        return cV
    }()
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Color.cellBackground
        view.layer.borderColor = Color.cellBorder.cgColor
        view.layer.borderWidth = 1
        
        return view
    }()
    
    var relatedItems: [TraktTvShow]?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.black
        mainView.addSubview(collectionView)
        contentView.addSubview(mainView)
        
        collectionView.pinEdgesToSuperview(margin: 8)
        mainView.pinEdgesToSuperview(margin: 8)
        
        collectionView.register(TvShowRelatedCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: TvShowRelatedCollectionViewCell.self))
        
        let collectionViewLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        collectionViewLayout.estimatedItemSize = CGSize(width: 40, height: 40)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension TvShowRelatedShowsTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return relatedItems == nil ? 0: relatedItems!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let tvShowRelatedCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TvShowRelatedCollectionViewCell.self), for: indexPath) as! TvShowRelatedCollectionViewCell
        
        
        return tvShowRelatedCell
    }
}
