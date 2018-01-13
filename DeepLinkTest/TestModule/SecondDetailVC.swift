//
//  SecondDetailVC.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/8/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation
import UIKit

class SecondDetailVC:UIViewController,DataTransferProtocol {
    var stringData:String?
    
    let testModelPresenter:AnotherTestModulePresenter = AnotherTestModulePresenter()
    
    @IBOutlet weak var testDetailLabel: UILabel!
    @IBOutlet weak var testField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = stringData {
            testDetailLabel.text = data
        }
    }
    
    @IBAction func setDataToFirstVC(_ sender: UIButton) {
        guard let data = testField.text else {
            return
        }
        testModelPresenter.sendDataWithLink(link: "/firstModule/firstDetailVC", data: data)
    }
    func setData(data: Any?) {
        guard let stringData = data as? String else{
            return
        }
        self.stringData = stringData
    }
}
