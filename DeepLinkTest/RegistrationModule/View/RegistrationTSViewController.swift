//
//  AuthroziationTSViewController.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/11/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import UIKit

class RegistrationTSViewController: UIViewController,PresenterProtocol {
    let registrationModuleInteractor:RegistrationModulePresenter = RegistrationModulePresenter()
    
    @IBAction func toSecondStep(_ sender: UIButton) {
        registrationModuleInteractor.presentRegistrationSecondStep()
    }
    
    @IBAction func endRegistration(_ sender: UIButton) {
    }
    
    @IBAction func toSwitch(_ sender: UIButton) {
        registrationModuleInteractor.presentSwitch()
    }
}
