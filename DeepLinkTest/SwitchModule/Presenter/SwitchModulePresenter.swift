//
//  SwitchModulePresenter.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/11/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation

class SwitchModulePresenter {
    var registrationProcessStarted:Bool = false
    init() {
        print("SWITCH MODULE PRESENTER INIT \(self)")
        
//        MainRouter.instance.addObserver(link: "/registrationFirstStep", id: "SwitchModulePresenter") { [weak self] in
//            print("OBSERVER ACTION ")
//            self?.registrationProcessStarted = true
//        }
//        MainRouter.instance.addObserver(link: "/registrationFirstStep", id: "SwitchModulePresenterAnotherID") {
//            print("REGISTRATION FIRST STEP STARTED")
//        }
    }
    
    func presentAuthModule() {
        MainRouter.instance.navigate(to: "/authorization")
    }
    
    func presentRegModule() {
        MainRouter.instance.configureModule(with: "/registration")
        print("PRESENT REG MODULE PROCESS STARTED \(registrationProcessStarted)")
        if (!registrationProcessStarted){
            MainRouter.instance.navigate(to: "/registrationFirstStep")
        }
        MainRouter.instance.presentModule(with: "/registration")
    }
    
    func toMainModule() {
        MainRouter.instance.presentModule(with: "/firstModule")
    }
}

