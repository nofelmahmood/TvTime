//
//  TvShowRelatedShowsTableViewCell.swift
//  TvTime
//
//  Created by Nofel Mahmood on 21/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit
import AlamofireImage

class TvShowRelatedShowsTableViewCell: UITableViewCell {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cV = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cV.translatesAutoresizingMaskIntoConstraints = false
        cV.backgroundColor = Color.cellBackground
        
        return cV
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Font.name, size: 18)
        label.textColor = UIColor.white
        label.text = "Related"
        
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let sV = UIStackView(arrangedSubviews: [self.titleLabel, self.collectionView])
        sV.translatesAutoresizingMaskIntoConstraints = false
        sV.axis = .vertical
        sV.distribution = .fillProportionally
        sV.alignment = .fill
        sV.spacing = 8
        
        return sV
    }()
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Color.cellBackground
        view.layer.borderColor = Color.cellBorder.cgColor
        view.layer.borderWidth = 1
        
        return view
    }()
    
    var relatedItems: [TraktTvShow]? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var onRelatedTvShowButtonPress: ((_ tvShow: TraktTvShow) -> Void)?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.black
        mainView.addSubview(stackView)
        contentView.addSubview(mainView)
        
        mainView.pinEdgesToSuperview(margin: 8)
        stackView.pinEdgesToSuperview(margin: 8)
        
        collectionView.register(TvShowRelatedCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: TvShowRelatedCollectionViewCell.self))
        
        let collectionViewLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        collectionViewLayout.estimatedItemSize = CGSize(width: 90, height: 125)
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 8
        
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.heightAnchor.constraint(equalToConstant: 150).isActive = true

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
        
        let tvShow = relatedItems![indexPath.row]
        let trakt = Trakt()
        tvShowRelatedCell.onButtonPress = {
            self.onRelatedTvShowButtonPress?(tvShow)
        }
        
        if tvShow.imdbID != nil {
            
            trakt.getPosterURL(imdbID: tvShow.imdbID)
                .then(execute: { (result) -> Void in
                    
                    let posterURLString = result as! String
                    let url = URL(string: posterURLString)!
                    
                    tvShowRelatedCell.setImage(url: url)
                })
        }
        
        return tvShowRelatedCell
    }
}
