//
//  TvShowDetailTableViewCell.swift
//  TvTime
//
//  Created by Nofel Mahmood on 10/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit

class TvShowDetailTableViewCell: UITableViewCell {

    lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var infoTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Information"
        label.textColor = UIColor.white
        label.font = UIFont(name: Font.name, size: 16)
        
        return label
    }()
    
    lazy var ratedStackView: UIStackView = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: Font.name, size: 15)
        titleLabel.textColor = UIColor.white
        titleLabel.text = "Rated"
        
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont(name: Font.name, size: 15)
        descriptionLabel.textColor = Color.silver
        descriptionLabel.textAlignment = .right
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        
        return stackView
    }()
    
    lazy var genreStackView: UIStackView = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: Font.name, size: 15)
        titleLabel.textColor = UIColor.white
        titleLabel.text = "Genre"
        
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont(name: Font.name, size: 15)
        descriptionLabel.textColor = Color.silver
        descriptionLabel.numberOfLines = 3
        descriptionLabel.textAlignment = .right
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    lazy var totalSeasonsStackView: UIStackView = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: Font.name, size: 15)
        titleLabel.textColor = UIColor.white
        titleLabel.text = "Seasons"
        
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont(name: Font.name, size: 15)
        descriptionLabel.textColor = Color.silver
        descriptionLabel.textAlignment = .right
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        
        return stackView
    }()
    
    lazy var imdbRatingStackView: UIStackView = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: Font.name, size: 15)
        titleLabel.textColor = UIColor.white
        titleLabel.text = "Rating"
        
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont(name: Font.name, size: 15)
        descriptionLabel.textColor = Color.silver
        descriptionLabel.textAlignment = .right
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        
        return stackView
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(onFavoriteButtonPress), for: .touchUpInside)
        
        return button
    }()
    
    lazy var awardsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Font.name, size: 15)
        label.textAlignment = .center
        label.textColor = Color.silver
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.ratedStackView, self.genreStackView, self.totalSeasonsStackView, self.imdbRatingStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        
        return stackView
    }()
    
    lazy var stackView: UIStackView = {
        let sV = UIStackView(arrangedSubviews: [self.itemImageView, self.infoStackView])
        sV.translatesAutoresizingMaskIntoConstraints = false
        sV.axis = .horizontal
        sV.distribution = .fillProportionally
        sV.alignment = .top
        sV.spacing = 16
        
        return sV
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.stackView, self.awardsLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 16
        
        return stackView
    }()
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Color.cellBackground
        view.layer.borderColor = Color.cellBorder.cgColor
        view.layer.borderWidth = 1
        
        return view
    }()
    
    var favorited: Bool = false {
        didSet {
            if favorited {
                favoriteButton.setImage(UIImage(named: "favorites_fill"), for: .normal)
            } else {
                favoriteButton.setImage(UIImage(named: "favorites_medium"), for: .normal)
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.black
        
        mainView.addSubview(mainStackView)
        contentView.addSubview(mainView)
        
        mainView.pinEdgesToSuperview(margin: 8)

        let widthItemImageView: CGFloat = 135
        let heightItemImageview: CGFloat = 188
        
        itemImageView.widthAnchor.constraint(equalToConstant: widthItemImageView).isActive = true
        itemImageView.heightAnchor.constraint(equalToConstant: heightItemImageview).isActive = true
        
        let favoriteButtonWidth: CGFloat = 35
        let favoriteButtonHeight: CGFloat = 33
        
        favoriteButton.widthAnchor.constraint(equalToConstant: favoriteButtonWidth).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: favoriteButtonHeight).isActive = true
        
        favorited = true
        
      //  awardsLabel.pinEdgesToSuperview(margin: 8)
        mainStackView.pinEdgesToSuperview(margin: 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setInfo(info: IMDBTvShow?) {
        
        guard let info = info else {
            return
        }
        
        let genreLabel = genreStackView.arrangedSubviews[1] as! UILabel
        genreLabel.text = info.genre
        
        let ratedLabel = ratedStackView.arrangedSubviews[1] as! UILabel
        ratedLabel.text = info.rated
        
        let seasonsLabel = totalSeasonsStackView.arrangedSubviews[1] as! UILabel

        if info.totalSeasons != nil {
            seasonsLabel.text = info.totalSeasons
        }
        
        setIMDBRating(rating: info.rating)
        
        awardsLabel.text = info.awards
    }
    
    func setIMDBRating(rating: String) {
        
        let textAttachment = NSTextAttachment()
        textAttachment.image = UIImage(named: "imdb")
        
        let attributedString = NSAttributedString(attachment: textAttachment)
        let originalAttrString = NSMutableAttributedString(string: "  \(rating)")
        originalAttrString.insert(attributedString, at: 0)
        
        let imdbRatingLabel = imdbRatingStackView.arrangedSubviews[1] as! UILabel
        imdbRatingLabel.attributedText = originalAttrString
        
    }
    
    func onFavoriteButtonPress() {
        
    }

}
