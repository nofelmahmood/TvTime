//
//  TvShowRelatedCollectionViewCell.swift
//  TvTime
//
//  Created by Nofel Mahmood on 21/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit
import AlamofireImage

class TvShowRelatedCollectionViewCell: UICollectionViewCell {
    
    lazy var tvShowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var tvShowButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let imageViewWidth: CGFloat = 92
        let imageViewHeight: CGFloat = 125
        
 //       contentView.addSubview(tvShowImageView)
        
        contentView.addSubview(tvShowButton)
        
        tvShowButton.pinEdgesToSuperview(margin: 8)
        tvShowButton.widthAnchor.constraint(equalToConstant: imageViewWidth).isActive = true
        tvShowButton.heightAnchor.constraint(equalToConstant: imageViewHeight).isActive = true
        
   //     tvShowImageView.pinEdgesToSuperview(margin: 8)
     //   tvShowImageView.widthAnchor.constraint(equalToConstant: imageViewWidth).isActive = true
       // tvShowImageView.heightAnchor.constraint(equalToConstant: imageViewHeight).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func setImage(url: URL) {
        tvShowButton.imageView?.image = nil
        tvShowButton.af_setImage(for: .normal, url: url)
    }
    
}
