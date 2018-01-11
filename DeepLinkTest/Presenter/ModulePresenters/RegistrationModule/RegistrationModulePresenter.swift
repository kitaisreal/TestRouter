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
        MainRouter.instance.navigateToLink(to: "/switch")
    }
    func presentRegistrationFirstStep() {
        MainRouter.instance.navigateToLink(to: "/registrationFirstStep")
    }
    func presentRegistrationSecondStep() {
        MainRouter.instance.navigateToLink(to: "/registrationSecondStep")
    }
    func presentRegistrationThirdStep() {
        MainRouter.instance.navigateToLink(to: "/registrationThirdStep")
    }
    
}
