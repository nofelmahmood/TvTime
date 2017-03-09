//
//  ItemTableViewCell.swift
//  TvTime
//
//  Created by Nofel Mahmood on 08/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "ArialMT", size: 18)
        label.textColor = Color.silver
        label.text = ""
        
        return label
    }()
    
    lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.black
        
        contentView.addSubview(itemImageView)
        contentView.addSubview(nameLabel)
        
        let width: CGFloat = 90
        let height: CGFloat = 125
        
        nameLabel.pinLeadingToTrailing(ofView: itemImageView, margin: 16.0)
        nameLabel.centerVertically()
        
        itemImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        itemImageView.heightAnchor.constraint(equalToConstant: height).isActive = true
        itemImageView.pinTopAndBottomToSuperview(margin: 8.0)
        itemImageView.pinLeadingToSuperview(margin: 16.0)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
