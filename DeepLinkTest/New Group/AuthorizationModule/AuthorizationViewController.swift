//
//  AuthorizationViewController.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/11/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation
import UIKit

class AuthorizationViewController:UIViewController,PresenterProtocol {
    let authorizationModulePresenter:AuthorizationModulePresenter = AuthorizationModulePresenter()
    
    @IBAction func logIn(_ sender: UIButton) {
        
    }
    
    @IBAction func toSwitch(_ sender: UIButton) {
        authorizationModulePresenter.presentSwitchModule()
    }
    
}
extension AuthorizationViewController:UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FlipPresentAnimationController()
    }
}
class FlipPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 10.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to)
            else {
                return
        }
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        containerView.addSubview(fromVC.view)
        toVC.view.isHidden = true
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {}) { value in
            toVC.view.isHidden = false
            fromVC.removeFromParentViewController()
            transitionContext.completeTransition(true)
        }
    }
    
}
