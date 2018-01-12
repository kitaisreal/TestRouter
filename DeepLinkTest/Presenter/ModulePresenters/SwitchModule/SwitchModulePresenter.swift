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
        MainRouter.instance.addObserver(link: "/registrationFirstStep", id: "SwitchModulePresenter") { [weak self] in
            print("ACTION IN OBSERVER ")
            self?.registrationProcessStarted = true
        }
    }
    
    func presentAuthModule() {
        MainRouter.instance.navigate(to: "/authorization")
    }
    
    func presentRegModule() {
        print("PRESENT REG MODULE PROCESS STARTED \(registrationProcessStarted)")
        if (registrationProcessStarted){
            MainRouter.instance.navigate(to: "/registration")
        } else {
            MainRouter.instance.navigate(to: "/registrationFirstStep")
        }
    }
    
    func toMainModule() {
        MainRouter.instance.navigateToModule(with: "/firstModule")
    }
}

