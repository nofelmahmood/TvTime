//
//  FeedItemCollectionViewCell.swift
//  TvTime
//
//  Created by Nofel Mahmood on 20/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit

class FeedItemCollectionViewCell: UICollectionViewCell {
    
    lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var nameAndFavoriteBtnSV: UIStackView = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont(name: Font.name, size: 16)
        nameLabel.textColor = Color.silver
        
        let favoriteButton = UIButton()
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.setImage(UIImage(named: "favorites_medium"), for: .normal)
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, favoriteButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        
        return stackView
    }()
    
    lazy var stackView: UIStackView = {
        let sV = UIStackView(arrangedSubviews: [self.itemImageView, self.nameAndFavoriteBtnSV])
        sV.translatesAutoresizingMaskIntoConstraints = false
        sV.axis = .vertical
        sV.distribution = .fillProportionally
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor.black
        mainView.addSubview(stackView)
        contentView.addSubview(mainView)
        
        stackView.pinEdgesToSuperview(margin: 10)
        mainView.pinEdgesToSuperview()
        
        let favoriteButtonWidth: CGFloat = 32
        let favoriteButtonHeight: CGFloat = 30
        
        let favoriteButton = nameAndFavoriteBtnSV.arrangedSubviews[1] as! UIButton
        favoriteButton.widthAnchor.constraint(equalToConstant: favoriteButtonWidth).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: favoriteButtonHeight).isActive = true
        
        let itemImageWidth: CGFloat = 152
        let itemImageHeight: CGFloat = 208
        
        itemImageView.widthAnchor.constraint(equalToConstant: itemImageWidth).isActive = true
        itemImageView.heightAnchor.constraint(equalToConstant: itemImageHeight).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func setTvShow(tvShow: TraktTvShow?) {
        guard let tvShow = tvShow else {
            return
        }
        
        let nameLabel = nameAndFavoriteBtnSV.arrangedSubviews[0] as! UILabel
        nameLabel.text = tvShow.title
        
        itemImageView.image = nil
    }
}
