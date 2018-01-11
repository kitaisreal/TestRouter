//
//  SwitchViewController.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/11/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import UIKit

class SwitchViewController: UIViewController,PresenterProtocol {
    
    
    let switchModulePresenter:SwitchModulePresenter = SwitchModulePresenter()
    
    @IBAction func toRegistration(_ sender: Any) {
        switchModulePresenter.presentRegModule()
    }
    
    @IBAction func toAuthorization(_ sender: UIButton) {
        switchModulePresenter.presentAuthModule()
    }
    @IBAction func toMain(_ sender: UIButton) {
        switchModulePresenter.toMainModule()
    }
}
