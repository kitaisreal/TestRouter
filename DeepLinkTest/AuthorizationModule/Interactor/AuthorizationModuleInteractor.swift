//
//  AuthorizationModelInteractor.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/11/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation

class AuthorizationModuleInteractor {
    init() {
        
    }
    
    func checkAuthorization(name:String, surname:String) -> Bool{
        let registrationModel = RegistrationModuleModel(name: name, surname: surname)
        return RegistrationModuleInteractor.instance.authRegistrationModel(registrationModel: registrationModel)
    }
}
