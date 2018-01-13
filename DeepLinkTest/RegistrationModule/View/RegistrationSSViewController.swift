//
//  AuthorizationSSViewController.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/11/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import UIKit

class RegistrationSSViewController: UIViewController,PresenterProtocol,UINavigationControllerDelegate {
    let registrationModuleInteractor:RegistrationModulePresenter = RegistrationModulePresenter()
    
    override func viewDidLoad() {
        self.navigationController?.delegate = self
    }
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
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .none:
            return nil
        case .push:
            print("REGISTRATION STEP SECOND PUSH ANIMATION")
            return AnimationController(withDuration: 1.0, forTransitionType: .Presenting, originFrame: self.view.frame)
        case .pop:
            print("REGISTRATION STEP SECOND POP ANIMATION")
            registrationModuleInteractor.presentRegistrationFirstStep()
            return AnimationController(withDuration: 1.0, forTransitionType: .Dismissing, originFrame: self.view.frame)
        }
    }
}
