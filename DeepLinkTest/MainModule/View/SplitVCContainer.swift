//
//  SplitVCContainer.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/10/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation
import UIKit

class SplitVCDefaultContainer:UISplitViewController, ContainerProtocol,RootProtocol {
    
    func contain(modules: [NavigationProtocol]) {
        print("FAST BUG \(modules.count)")
        guard let containModules = modules as? [UIViewController], containModules.count == 2 else {
            return
        }
        self.viewControllers = containModules
    }
    
    func contain(modules: [PresenterProtocol]) {
        print("FAST BUG \(modules.count)")
        guard let containModules = modules as? [UIViewController], containModules.count == 2 else {
            return
        }
        self.viewControllers = containModules
    }
}
class VCDefaultContainer:UIViewController, ContainerProtocol {
    func contain(modules: [NavigationProtocol]) {
        guard let containModules = modules as? [UIViewController], containModules.count == 1 else {
            return
        }
        self.present(containModules[0], animated: false, completion: nil)
    }
    
    func contain(modules:[PresenterProtocol]) {
        guard let containModules = modules as? [UIViewController], containModules.count == 1 else {
            return
        }
        self.present(containModules[0], animated: false)
    }
}
