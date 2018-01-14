//
//  ViewPushProtocol.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/9/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation
import UIKit

protocol RootProtocol {
    
}

protocol NavigationProtocol {
    func push(module:PresenterProtocol)
    func removeFromTop()
    func getTopModule() -> PresenterProtocol?
}

protocol PresenterProtocol {
    
}

protocol DataTransferProtocol {
    func setData(data:Any?)
}


protocol ContainerProtocol {
    func contain(modules:[RootProtocol])
}

protocol ModuleContainerProtocol {
    func setData(with data:Any?, to module:Any?)
}

