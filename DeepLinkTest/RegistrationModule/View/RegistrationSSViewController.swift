//
//  AuthorizationSSViewController.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/11/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import UIKit

class RegistrationSSViewController: UIViewController,PresenterProtocol {
    let registrationModuleInteractor:RegistrationModulePresenter = RegistrationModulePresenter()
    
    @IBOutlet weak var surnameTextField: UITextField!
    
    @IBAction func toThirdRegistrationStep(_ sender: UIButton) {
        registrationModuleInteractor.presentRegistrationThirdStep()
    }
    
    @IBAction func toFirstRegistrationStep(_ sender: UIButton) {
        registrationModuleInteractor.presentRegistrationFirstStep()
    }
    
    @IBAction func toSwitch(_ sender: UIButton) {
        registrationModuleInteractor.presentSwitch()
    }
    
}
