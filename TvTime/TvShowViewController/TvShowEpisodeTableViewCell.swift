//
//  TvShowEpisodeTableViewCell.swift
//  TvTime
//
//  Created by Nofel Mahmood on 20/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit

class TvShowEpisodeTableViewCell: UITableViewCell {
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Font.name, size: 16)
        label.textColor = Color.silver
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Font.name, size: 20)
        label.textColor = Color.silver
        
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let sV = UIStackView(arrangedSubviews: [self.numberLabel, self.nameLabel])
        sV.translatesAutoresizingMaskIntoConstraints = false
        sV.axis = .horizontal
        sV.distribution = .fillProportionally
        sV.alignment = .fill
        sV.spacing = 20
        
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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
 
    //    contentView.layer.borderColor = Color.cellBorder.cgColor
      //  contentView.layer.borderWidth = 1
        
        contentView.superview?.backgroundColor = UIColor.black
        //accessoryType = .disclosureIndicator
        
        mainView.addSubview(stackView)
        contentView.addSubview(mainView)
        
        stackView.pinEdgesToSuperview(margin: 8)
        mainView.pinEdgesToSuperview(margin: 8)
        stackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Helpers
    
    func setEpisode(episode: TraktEpisode?) {
        
        guard let episode = episode else {
            return
        }
        
        numberLabel.text = "\(episode.number!)"
        nameLabel.text = episode.title
        
        if episode.title == nil {
            nameLabel.text = "Episode \(episode.number!)"
        }
    }

}
