//
//  RegistrationModuleInteractor.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/11/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation

class RegistrationModuleInteractor {
    static let instance = RegistrationModuleInteractor()
    var registrationModel:RegistrationModuleModel?
    
    private init() {
        
    }
    
    func setRegistrationModel(registrationModel:RegistrationModuleModel) {
        self.registrationModel = registrationModel
    }
    
    func checkRegistration() -> Bool {
        if (registrationModel != nil) {
            return true
        }
        return false
    }
    func authRegistrationModel(registrationModel:RegistrationModuleModel) -> Bool{
        if (registrationModel.name == self.registrationModel?.name && registrationModel.surname == self.registrationModel?.surname) {
            return true
        }
        return false
    }
}
