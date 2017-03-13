//
//  TvShowSeasonTableViewCell.swift
//  TvTime
//
//  Created by Nofel Mahmood on 13/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit

class TvShowSeasonTableViewCell: UITableViewCell {

    lazy var seasonPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var seasonLabelsStackView: UIStackView = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: Font.name, size: 15)
        titleLabel.textColor = Color.silver
        
        let numberOfEpLabel = UILabel()
        numberOfEpLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfEpLabel.font = UIFont(name: Font.name, size: 14)
        numberOfEpLabel.textColor = Color.silver
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, numberOfEpLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 4
        
        return stackView
    }()
    
    lazy var stackView: UIStackView = {
        let sV = UIStackView(arrangedSubviews: [self.seasonPhotoImageView, self.seasonLabelsStackView])
        sV.translatesAutoresizingMaskIntoConstraints = false
        sV.distribution = .fill
        sV.alignment = .fill
        sV.axis = .horizontal
        sV.spacing = 8
        
        return sV
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.black
        
        contentView.addSubview(stackView)
        
        let widthSeasonPhoto: CGFloat = 59
        let heightSeasonPhoto: CGFloat = 82
        
        seasonPhotoImageView.widthAnchor.constraint(equalToConstant: widthSeasonPhoto).isActive = true
        seasonPhotoImageView.heightAnchor.constraint(equalToConstant: heightSeasonPhoto).isActive = true
        
        stackView.pinEdgesToSuperview(margin: 8)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setSeason(season: Season?) {
        
        guard let season = season else {
            return
        }
        
        seasonPhotoImageView.image = nil
        
        if let seasonThumbnailStringURL = season.thumbnailURL {
            let stringURL = "\(APIEndPoint.image)\(seasonThumbnailStringURL)"
            let url = URL(string: stringURL)!
            
            seasonPhotoImageView.af_setImage(withURL: url)
        }
        
        let titleLabel = seasonLabelsStackView.arrangedSubviews[0] as! UILabel
        titleLabel.text = "Season \(season.order!)"
        
        let numberOfEpLabel = seasonLabelsStackView.arrangedSubviews[1] as! UILabel
        numberOfEpLabel.text = "\(season.episodeCount!) episode"
        
        if season.episodeCount > 1 {
            numberOfEpLabel.text = "\(numberOfEpLabel.text!)s"
        }
    }
}
