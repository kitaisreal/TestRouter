//
//  AuthorizationFSViewController.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/11/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import UIKit

class RegistrationFSViewController: UIViewController,PresenterProtocol,UINavigationControllerDelegate {
    let registrationModuleInteractor:RegistrationModulePresenter = RegistrationModulePresenter()
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBAction func toNextStep(_ sender: UIButton) {
        registrationModuleInteractor.presentRegistrationSecondStep()
    }
    @IBAction func toWitch(_ sender: UIButton) {
        registrationModuleInteractor.presentSwitch()
    }
    override func viewDidLoad() {
        self.navigationController?.delegate = self
    }
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .none:
            print("NONE")
            return nil
        case .push:
            print("REGISTRATION STEP FIRST PUSH ANIMATION")
            return AnimationController(withDuration: 1.0, forTransitionType: .Presenting, originFrame: self.view.frame)
        case .pop:
            print("REGISTRATION STEP FIRST POP ANIMATION")
            return AnimationController(withDuration: 1.0, forTransitionType: .Dismissing, originFrame: self.view.frame)
        }
    }
}
enum TransitionType {
    case Presenting, Dismissing
}

class AnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        let fromView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!.view
        let toView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!.view
        
        let detailView = self.isPresenting ? toView : fromView
        
        if self.isPresenting {
            containerView.addSubview(toView!)
        } else {
            containerView.insertSubview(toView!, belowSubview: fromView!)
        }
        
        detailView?.frame.origin = self.isPresenting ? self.originFrame.origin : CGPoint(x: 0, y: 0)
        detailView?.frame.size.width = self.isPresenting ? self.originFrame.size.width : containerView.bounds.width
        detailView?.layoutIfNeeded()
        
        for view in (detailView?.subviews)! {
            if !(view is UIImageView) {
                view.alpha = isPresenting ? 0.0 : 1.0
            }
        }
        
        UIView.animate(withDuration: self.duration, animations: { () -> Void in
            detailView?.frame = self.isPresenting ? containerView.bounds : self.originFrame
            detailView?.layoutIfNeeded()
            
            for view in (detailView?.subviews)! {
                if !(view is UIImageView) {
                    view.alpha = self.isPresenting ? 1.0 : 0.0
                }
            }
        }) { (completed: Bool) -> Void in
            transitionContext.completeTransition(true)
        }
    }
    
    var duration: TimeInterval
    var isPresenting: Bool
    var originFrame: CGRect
    
    init(withDuration duration: TimeInterval, forTransitionType type: TransitionType, originFrame: CGRect) {
        self.duration = duration
        self.isPresenting = type == .Presenting
        self.originFrame = originFrame
        
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
}

