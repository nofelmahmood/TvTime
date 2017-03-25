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
    
    lazy var tvShowButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(onTvShowButtonPress), for: .touchUpInside)
        
        return button
    }()
    
    var onButtonPress: ((_ image: UIImage?) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let imageViewWidth: CGFloat = 128.8
        let imageViewHeight: CGFloat = 175
        
        contentView.addSubview(tvShowButton)
        
        tvShowButton.imageView?.contentMode = .scaleAspectFit
        
        tvShowButton.pinEdgesToSuperview(margin: 4)
        tvShowButton.widthAnchor.constraint(equalToConstant: imageViewWidth).isActive = true
        tvShowButton.heightAnchor.constraint(equalToConstant: imageViewHeight).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func setImage(url: URL) {
        tvShowButton.imageView?.image = nil
        tvShowButton.af_setImage(for: .normal, url: url)
    }
    
    func onTvShowButtonPress() {
        let image = tvShowButton.imageView?.image
        onButtonPress?(image)
    }
    
}
