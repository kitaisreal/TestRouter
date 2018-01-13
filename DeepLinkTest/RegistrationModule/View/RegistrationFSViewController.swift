//
//  AuthorizationFSViewController.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/11/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import UIKit

class RegistrationFSViewController: UIViewController,PresenterProtocol,UINavigationControllerDelegate {
    let registrationModuleInteractor:RegistrationModulePresenter = RegistrationModulePresenter()
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBAction func toNextStep(_ sender: UIButton) {
        registrationModuleInteractor.presentRegistrationSecondStep()
    }
    @IBAction func toWitch(_ sender: UIButton) {
        registrationModuleInteractor.presentSwitch()
    }
    override func viewDidLoad() {
        print("ANIMATION BUG \(self.navigationController)")
        self.navigationController?.delegate = self
        print("SELF NAVIGATION CONTROLLER DELEGATE \(self.navigationController?.delegate)")
    }
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print("SOME ANIMATION OPERATION")
        print(operation)
        return nil
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        print("SOMESHIT 1")
    }
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        print("SOMESHIT 2")
    }
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        print("SOMESHIT 3")
        return nil
    }
}

