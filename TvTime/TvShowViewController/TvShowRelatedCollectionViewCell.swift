//
//  TvShowRelatedCollectionViewCell.swift
//  TvTime
//
//  Created by Nofel Mahmood on 21/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit

class TvShowRelatedCollectionViewCell: UICollectionViewCell {
    
    lazy var tvShowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let imageViewWidth: CGFloat = 92
        let imageViewHeight: CGFloat = 125
        
        contentView.addSubview(tvShowImageView)
        
        tvShowImageView.widthAnchor.constraint(equalToConstant: imageViewWidth).isActive = true
        tvShowImageView.heightAnchor.constraint(equalToConstant: imageViewHeight).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func setTvShow(tvShow: TvShow?) {
        
        guard let tvShow = tvShow else {
            return
        }
        
    }
}
