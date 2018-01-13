//
//  AuthorizationNavigation.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/11/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import UIKit

class RegistrationNavigation: UINavigationController,NavigationProtocol,RootProtocol,UINavigationBarDelegate {
    
    func push(module: PresenterProtocol) {
        guard let VC = module as? UIViewController else {
            return
        }
        print("REGISTRATION STEP PUSH MODULE PUSH")
        self.pushViewController(VC, animated: true)
    }
    
    override func viewDidLoad() {
        self.navigationBar.delegate = self
    }
    func removeFromTop() {
        print("REGISTRATION STEP POP MODULE POP")
        self.popViewController(animated: true)
    }
    
    func getTopModule() -> PresenterProtocol? {
        return self.topViewController as? PresenterProtocol
    }
    func navigationBar(_ navigationBar: UINavigationBar, didPop item: UINavigationItem) {
        print("REGISTRATION STEPS POP OPERATION")
    }
    func navigationBar(_ navigationBar: UINavigationBar, didPush item: UINavigationItem) {
        print("REGISTRATION STEPS PUSH OPERATION")
    }
}


