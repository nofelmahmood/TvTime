//
//  TvShowOverviewTableViewCell.swift
//  TvTime
//
//  Created by Nofel Mahmood on 12/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit

class TvShowOverviewTableViewCell: UITableViewCell {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Font.name, size: 16)
        label.textColor = UIColor.white
        label.text = "Overview"
        
        return label
    }()
    
    lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Font.name, size: 15)
        label.textColor = Color.silver
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let sV = UIStackView(arrangedSubviews: [self.titleLabel, self.overviewLabel])
        sV.translatesAutoresizingMaskIntoConstraints = false
        sV.axis = .vertical
        sV.distribution = .fill
        sV.spacing = 6
        
        return sV
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.black
        
        contentView.addSubview(stackView)
        
        stackView.pinEdgesToSuperview(margin: 8)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
