//
//  TvShowCastHeaderView.swift
//  TvTime
//
//  Created by Nofel Mahmood on 13/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit

class TvShowHeaderFooterView: UITableViewHeaderFooterView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Font.name, size: 16)
        label.textColor = UIColor.white
        
        return label
    }()
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black
        view.backgroundColor = UIColor.green
        
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.black
        contentView.backgroundColor = UIColor.black
        mainView.backgroundColor = UIColor.black
        
        mainView.addSubview(titleLabel)
        contentView.addSubview(mainView)
        
        titleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 17).isActive = true
        mainView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func setTitle(title: String) {
        titleLabel.text = title
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
