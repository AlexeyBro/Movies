//
//  ProfileInTransition.swift
//  Movies
//
//  Created by Alex Bro on 22.12.2020.
//

import UIKit

final class ProfileInTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting = false
    private let backgroundView = UIView()
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
              let fromViewController = transitionContext.viewController(forKey: .from) else { return }
        
        let containerView = transitionContext.containerView
        
        let finalWight = toViewController.view.bounds.width * 0.8
        let finalHeight = toViewController.view.bounds.height
        
        if isPresenting {
            backgroundView.backgroundColor = .darkBlue
            backgroundView.alpha = 0
            backgroundView.frame = containerView.bounds
            containerView.addSubview(backgroundView)
            containerView.addSubview(toViewController.view)
            toViewController.view.frame = CGRect(x: -finalWight, y: 0, width: finalWight, height: finalHeight)
        }
        
        let transform = {
            self.backgroundView.alpha = 0.9
            toViewController.view.transform = CGAffineTransform(translationX: finalWight, y: 0)
        }
        
        let identity = {
            self.backgroundView.alpha = 0
            fromViewController.view.transform = .identity
        }
        
        let duration = transitionDuration(using: transitionContext)
        let isCanceled = transitionContext.transitionWasCancelled
        UIView.animate(withDuration: duration) {
            self.isPresenting ? transform() : identity()
        } completion: { (_) in
            transitionContext.completeTransition(!isCanceled)
        }
    }
}
