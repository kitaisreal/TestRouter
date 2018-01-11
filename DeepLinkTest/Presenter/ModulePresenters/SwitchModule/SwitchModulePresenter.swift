//
//  SwitchModulePresenter.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/11/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation

class SwitchModulePresenter {
    
    init() {
        
    }
    
    func presentAuthModule() {
        MainRouter.instance.navigateToLink(to: "/authorization")
    }
    
    func presentRegModule() {
        MainRouter.instance.navigateToLink(to: "/registrationFirstStep")
    }
    
    func toMainModule() {
        MainRouter.instance.navigateToLink(to: "/firstModule/data")
    }
}
