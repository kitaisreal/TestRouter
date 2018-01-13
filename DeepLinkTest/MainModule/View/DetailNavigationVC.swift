//
//  Detai;NavigationVC.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/10/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation
import UIKit

class DetailNavigationVC:UINavigationController,NavigationProtocol,RootProtocol,UINavigationControllerDelegate {

    override func viewDidLoad() {
        self.delegate = self
    }
    
    func push(module: PresenterProtocol) {
        print("FAST BUG FIX PUSH MODULE \(module)")
        guard let VC = module as? UIViewController else {
            return
        }
        self.pushViewController(VC, animated: false)
    }
    
    func removeFromTop() {
        self.popViewController(animated: false)
    }
    
    func getTopModule() -> PresenterProtocol? {
        return self.topViewController as? PresenterProtocol
    }
    private func navigationController(_: UINavigationController, animationControllerFor: UINavigationControllerOperation, from: UIViewController, to: UIViewController) {
        print("OPERATION \(animationControllerFor)")
    }
    
}
