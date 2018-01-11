//
//  AuthorizationViewController.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/11/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation
import UIKit

class AuthorizationViewController:UIViewController,PresenterProtocol {
    let authorizationModulePresenter:AuthorizationModulePresenter = AuthorizationModulePresenter()
    
    @IBAction func logIn(_ sender: UIButton) {
        
    }
    
    @IBAction func toSwitch(_ sender: UIButton) {
        authorizationModulePresenter.presentSwitchModule()
    }
}
