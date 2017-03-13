//
//  ItemTableViewCell.swift
//  TvTime
//
//  Created by Nofel Mahmood on 08/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit
import AlamofireImage

class ItemTableViewCell: UITableViewCell {

    lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var stackView: UIStackView = {
        let sV = UIStackView(arrangedSubviews: [self.itemImageView, self.detailStackView])
        sV.translatesAutoresizingMaskIntoConstraints = false
        sV.axis = .horizontal
        sV.distribution = .fillProportionally
        sV.spacing = 8
        
        return sV
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Font.name, size: 18)
        label.textColor = UIColor.white
        label.text = ""
        
        return label
    }()
    
    lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Font.name, size: 14)
        label.textColor = Color.silver
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var detailStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.nameAndFavoriteButtonSV, self.overviewLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 2
        
        return stackView
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(onFavoriteButtonPress), for: .touchUpInside)
        
        return button
    }()
    
    lazy var nameAndFavoriteButtonSV: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.nameLabel, self.favoriteButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 4
        
        return stackView
    }()
    
    var favorited: Bool = false {
        didSet {
            if favorited {
                favoriteButton.setImage(UIImage(named: "favorites_fill"), for: .normal)
            } else {
                favoriteButton.setImage(UIImage(named: "favorites"), for: .normal)
            }
        }
    }
    
    var onFavorite: (() -> Void)?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.black
        selectionStyle = .none
        
        contentView.addSubview(stackView)
        
        let width: CGFloat = 90
        let height: CGFloat = 125
        
        itemImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        itemImageView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        favoriteButton.widthAnchor.constraint(equalToConstant: 29.04).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: 27.72).isActive = true
        
        stackView.pinEdgesToSuperview(margin: 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - User Interaction
    
    func onFavoriteButtonPress() {
        onFavorite?()
    }
    
    
    // MARK: - Helpers
    
    func setTvShow(tvShow: TvShow?, row: Int) {
        
        guard let tvShow = tvShow else {
            return
        }
        
        nameLabel.text = tvShow.name
        overviewLabel.text = tvShow.overview
        favorited = tvShow.favorite
        tag = row
        itemImageView.image = nil
        
        guard let thumbnailURL = tvShow.thumbnailURL else {
            return
        }
        
        let thumbnailFullURL = "\(APIEndPoint.image)\(thumbnailURL)"
        let url = URL(string: thumbnailFullURL)
        let thumbnailRequest = URLRequest(url: url!)
        itemImageView.af_setImage(withURLRequest: thumbnailRequest)
    }

}
