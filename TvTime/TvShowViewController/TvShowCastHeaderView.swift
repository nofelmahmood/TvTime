//
//  TvShowCastHeaderView.swift
//  TvTime
//
//  Created by Nofel Mahmood on 13/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit

class TvShowCastHeaderView: UITableViewHeaderFooterView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Font.name, size: 16)
        label.text = "Cast"
        label.textColor = UIColor.white
        
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.black
        contentView.backgroundColor = UIColor.black
        
        contentView.addSubview(titleLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 9).isActive = true
        
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

}
