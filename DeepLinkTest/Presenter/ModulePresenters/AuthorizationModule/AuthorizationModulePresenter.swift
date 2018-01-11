//
//  AuthorizationModulePresenter.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/11/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation

class AuthorizationModulePresenter {
    let authorizationInteractor = AuthorizationModuleInteractor()
    
    init() {
    }
    
    func checkAuthorization(name:String, surname:String) -> Bool{
        return authorizationInteractor.checkAuthorization(name: name, surname: surname)
    }
    
    func presentMainModule() {
        
    }
    
    func presentSwitchModule() {
        MainRouter.instance.navigate(to: "/switch")
    }
}
