//
//  AuthorizationNavigation.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/11/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import UIKit

class RegistrationNavigation: UINavigationController,NavigationProtocol,RootProtocol,UINavigationBarDelegate,UINavigationControllerDelegate {
    
    func push(module: PresenterProtocol) {
        guard let VC = module as? UIViewController else {
            return
        }
        print("ANIMATION BUG MODULE PUSH \(VC)")
        self.pushViewController(VC, animated: true)
    }
    
    override func viewDidLoad() {
        self.navigationBar.delegate = self
        self.delegate = self
    }
    func removeFromTop() {
        print("REGISTRATION STEP POP MODULE POP")
//        self.popViewController(animated: true)
    }
    
    func getTopModule() -> PresenterProtocol? {
        return self.topViewController as? PresenterProtocol
    }
    func navigationBar(_ navigationBar: UINavigationBar, didPop item: UINavigationItem) {
        print("PREVIOUS LINK GET BACK IN MODULE ACTION")
        MainRouter.instance.getBackInModule(with: "/registration", data: nil)
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .none:
            return nil
        case .push:
            return AnimationController(withDuration: 1.0, forTransitionType: .Presenting, originFrame: self.view.frame)
        case .pop:
            return AnimationController(withDuration: 1.0, forTransitionType: .Presenting, originFrame: self.view.frame)
        }
    }
}


