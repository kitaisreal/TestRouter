//
//  DataNavigationVC.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/10/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation
import UIKit

class DataNavigationVC:UINavigationController,NavigationProtocol {
    
    func push(module: PresenterProtocol) {
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
    
    
}
