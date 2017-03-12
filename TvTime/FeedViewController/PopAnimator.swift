//
//  PopAnimator.swift
//  TvTime
//
//  Created by Nofel Mahmood on 10/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit

class PopAnimator: NSObject {

}

extension PopAnimator: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        guard let toViewController = transitionContext.viewController(forKey: .to), let fromViewController = transitionContext.viewController(forKey: .from) else {
            return
        }
        
        containerView.addSubview(fromViewController.view)
        containerView.addSubview(toViewController.view)
        
        toViewController.view.alpha = 0
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toViewController.view.alpha = 1
            fromViewController.view.alpha = 0
            
        }, completion: { completed in
            fromViewController.view.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
        
    }
}
