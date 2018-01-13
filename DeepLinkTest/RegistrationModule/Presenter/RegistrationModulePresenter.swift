//
//  RegistrationModulePresenter.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/11/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation

class RegistrationModulePresenter {
    
    init() {
        print("REGISTRATION MODULE PRESENTER INIT")
    }
    func presentSwitch() {
        MainRouter.instance.navigate(to: "switch", data: "SOME DATA")
        MainRouter.instance.presentModule(with: "/switch")
    }
    func presentRegistrationFirstStep() {
        MainRouter.instance.navigate(to: "/registrationFirstStep")
    }
    func presentRegistrationSecondStep() {
        MainRouter.instance.navigate(to: "/registrationSecondStep")
    }
    func presentRegistrationThirdStep() {
        MainRouter.instance.navigate(to: "/registrationThirdStep")
    }
    
}
