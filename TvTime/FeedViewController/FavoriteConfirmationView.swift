//
//  FavoriteConfirmationView.swift
//  TvTime
//
//  Created by Nofel Mahmood on 13/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit

class FavoriteConfirmationView: UIView {

    lazy var visualEffectView: UIVisualEffectView = {
        let visualEffect = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: visualEffect)
        
        return visualEffectView
    }()
    
    lazy var favoriteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "favorites_large_fill")
        
        return imageView
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Font.name, size: 16)
        label.textColor = Color.silver
        label.numberOfLines = 0
        label.text = "We will track this show for you."
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let sV = UIStackView(arrangedSubviews: [self.favoriteImageView, self.messageLabel])
        sV.translatesAutoresizingMaskIntoConstraints = false
        sV.axis = .vertical
        sV.distribution = .fillProportionally
        sV.alignment = .center
        sV.spacing = 8
        
        return sV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        favoriteImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        favoriteImageView.heightAnchor.constraint(equalToConstant: 76.36).isActive = true
        
        backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.9)
        layer.cornerRadius = 10
        layer.borderColor = Color.silver.cgColor
        layer.borderWidth = 1.0
        
        addSubview(stackView)
        
        stackView.pinTopToSuperview(margin: 16)
        stackView.pinBottomToSuperview(margin: 16)
        stackView.pinLeadingToSuperview(margin: 16)
        stackView.pinTrailingToSuperview(margin: 16)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // MARK: - Actions
    
    func setFavorite(favorite: Bool) {
        
        if favorite {
            favoriteImageView.image = UIImage(named: "favorites_large_fill")
            messageLabel.text = "We will start tracking this show for you."
            
        } else {
            favoriteImageView.image = UIImage(named: "favorites_large")
            messageLabel.text = "We will stop tracking this show for you."
        }
    }
    

}
