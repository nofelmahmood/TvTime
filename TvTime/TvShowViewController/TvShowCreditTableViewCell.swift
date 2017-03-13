//
//  TvShowCreditTableViewCell.swift
//  TvTime
//
//  Created by Nofel Mahmood on 12/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit
import AlamofireImage

class TvShowCreditTableViewCell: UITableViewCell {

    lazy var creditPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    lazy var nameLabelsStackView: UIStackView = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont(name: Font.name, size: 15)
        nameLabel.textColor = UIColor.white
        
        let characterNameLabel = UILabel()
        characterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        characterNameLabel.font = UIFont(name: Font.name, size: 15)
        characterNameLabel.textColor = Color.silver
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, characterNameLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        
        return stackView
    }()
    
    lazy var stackView: UIStackView = {
        let sV = UIStackView(arrangedSubviews: [self.creditPhotoImageView, self.nameLabelsStackView])
        sV.translatesAutoresizingMaskIntoConstraints = false
        sV.axis = .horizontal
        sV.distribution = .fillProportionally
        sV.alignment = .fill
        sV.spacing = 8
        
        return sV
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.black
        
        contentView.addSubview(stackView)
        
        let widthCreditPhotoImage: CGFloat = 60
        let heightCreditPhotoImage: CGFloat = 60
    
        creditPhotoImageView.widthAnchor.constraint(equalToConstant: widthCreditPhotoImage).isActive = true
        creditPhotoImageView.heightAnchor.constraint(equalToConstant: heightCreditPhotoImage).isActive = true
        
        creditPhotoImageView.layer.cornerRadius = widthCreditPhotoImage / 2
        
        stackView.pinEdgesToSuperview(margin: 8)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCredit(credit: Credit?) {
        
        guard let credit = credit else {
            return
        }
        
        creditPhotoImageView.image = nil
        
        if let creditImageThumbnailURL = credit.thumbnailURL {
            let thumbnailURLString = "\(APIEndPoint.image)\(creditImageThumbnailURL)"
            let thumbnailURL = URL(string: thumbnailURLString)!
            
            creditPhotoImageView.af_setImage(withURL: thumbnailURL)
        }
        
        let nameLabel = nameLabelsStackView.arrangedSubviews[0] as! UILabel
        nameLabel.text = credit.name
        
        let characterName = nameLabelsStackView.arrangedSubviews[1] as! UILabel
        characterName.text = credit.characterName
    }

}
