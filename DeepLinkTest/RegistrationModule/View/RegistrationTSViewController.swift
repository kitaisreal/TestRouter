//
//  AuthroziationTSViewController.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/11/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import UIKit

class RegistrationTSViewController: UIViewController,PresenterProtocol,UINavigationControllerDelegate {
    let registrationModuleInteractor:RegistrationModulePresenter = RegistrationModulePresenter()
    
    override func viewDidLoad() {
        self.navigationController?.delegate = self
    }
    @IBAction func toSecondStep(_ sender: UIButton) {
        registrationModuleInteractor.presentRegistrationSecondStep()
    }
    
    @IBAction func endRegistration(_ sender: UIButton) {
    }
    
    @IBAction func toSwitch(_ sender: UIButton) {
        registrationModuleInteractor.presentSwitch()
    }
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .none:
            return nil
        case .push:
            print("REGISTRATION STEP THIRD PUSH ANIMATION")
            return AnimationController(withDuration: 1.0, forTransitionType: .Presenting, originFrame: self.view.frame)
        case .pop:
            print("REGISTRATION STEP THIRD POP ANIMATION")
            registrationModuleInteractor.presentRegistrationSecondStep()
            return AnimationController(withDuration: 1.0, forTransitionType: .Dismissing, originFrame: self.view.frame)
        }
        return nil
    }
}
