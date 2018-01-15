//
//  AuthorizationFSViewController.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/11/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import UIKit

class RegistrationFSViewController: UIViewController,PresenterProtocol {
    let registrationModuleInteractor:RegistrationModulePresenter = RegistrationModulePresenter()
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBAction func toNextStep(_ sender: UIButton) {
        registrationModuleInteractor.presentRegistrationSecondStep()
    }
    @IBAction func toWitch(_ sender: UIButton) {
        registrationModuleInteractor.presentSwitch()
    }
}
