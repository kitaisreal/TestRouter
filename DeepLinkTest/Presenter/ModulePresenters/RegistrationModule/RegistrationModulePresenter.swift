//
//  RegistrationModulePresenter.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/11/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation

class RegistrationModulePresenter {
    
    func presentSwitch() {
        MainRouter.instance.navigate(to: "/switch")
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
