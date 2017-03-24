//
//  PushAnimator.swift
//  TvTime
//
//  Created by Nofel Mahmood on 10/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit

class PushAnimator: NSObject {

}

extension PushAnimator: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        guard let fromViewController = transitionContext.viewController(forKey: .from), let toViewController = transitionContext.viewController(forKey: .to) else {
            return
        }
        
        containerView.addSubview(fromViewController.view)
        containerView.addSubview(toViewController.view)
        
        let feedViewController = fromViewController as! FeedViewController
        let collectionView = feedViewController.collectionView
        
        let rect = CGRect.zero
        let rectInSuperview = collectionView.convert(rect, to: feedViewController.view)
        let  cell = collectionView.cellForItem(at: feedViewController.selectedRowIndexPath) as! FeedItemCollectionViewCell
        let image = cell.itemImageView.image
        
        let imageViewRect = CGRect(x: rectInSuperview.origin.x + 10, y: rectInSuperview.origin.y + 10, width: 90, height: 125)
        
        let imageView = UIImageView(frame: imageViewRect)
        imageView.image = image
        containerView.addSubview(imageView)
        
        let finalFrameWidth = 135
        let finalFrameHeight = 188
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        let navigationBarHeight: CGFloat = 52 + 8
        
        let finalFrame = CGRect(x: 16, y: Int(statusBarHeight + navigationBarHeight), width: finalFrameWidth, height: finalFrameHeight)
        
        toViewController.view.alpha = 0
        let tvShowViewController = toViewController as! TvShowViewController
        tvShowViewController.itemImageView.alpha = 0
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            
            imageView.frame = finalFrame
            toViewController.view.alpha = 1
            fromViewController.view.alpha = 0
            
        }, completion: { completed in
            
            fromViewController.view.removeFromSuperview()
            imageView.removeFromSuperview()
            tvShowViewController.itemImageView.alpha = 1.0
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })

        
    }
}
