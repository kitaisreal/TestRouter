//
//  FirstDetailVC.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/8/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation
import UIKit

class FirstDetailVC:UIViewController, DataTransferProtocol {
    var stringData:String? {
        didSet {
            guard let data = stringData, testDetailLabel != nil else {
                return
            }
            testDetailLabel.text = data
        }
    }
    
    @IBOutlet weak var testField: UITextField!
    let testModelPresenter:AnotherTestModulePresenter = AnotherTestModulePresenter()
    
    @IBOutlet weak var testDetailLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = stringData {
            testDetailLabel.text = data
        }
    }
    
    @IBAction func sendDataToSecondVC(_ sender: UIButton) {
        guard let data = testField.text else {
            return
        }
        testModelPresenter.sendDataWithLink(link: "/firstModule/secondDetailVC", data: data)
    }
    
    func setData(data: Any?) {
        guard let stringData = data as? String else{
            return
        }
        self.stringData = stringData
    }
}
