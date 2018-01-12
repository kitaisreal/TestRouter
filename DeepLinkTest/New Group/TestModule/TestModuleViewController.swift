//
//  TestModuleViewController.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/12/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import UIKit

class TestModuleViewController: UIViewController,PresenterProtocol {
    let testModulePresenter = TestModulePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TEST MODULE DID LOAD")
    }
    
}
