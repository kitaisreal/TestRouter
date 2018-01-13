//
//  DetailViewController.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/8/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,DataTransferProtocol,PresenterProtocol {
    
    let presenter = MainModulePresenter()
    
    @IBOutlet weak var testDetailLabel: UILabel!
    var data:String?
    
    @IBAction func presenterBack(_ sender: UIButton) {
        MainRouter.instance.navigate(to:"/firstModule", data: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = data {
            testDetailLabel.text = data
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //DATA PROBLEM FIX
    func setData(data: Any?) {
        if let testModel = data as? MainModuleModel {
            let title = testModel.testTitle
            self.data = title
            if (testDetailLabel != nil) {
                testDetailLabel.text = testModel.testTitle
            }
        }
        if let stringData = data as? String {
            self.data = stringData
            if (testDetailLabel != nil) {
                testDetailLabel.text = "Data from deeplink " + stringData
            }
        }
        
    }

    @IBAction func toSwitch(_ sender: UIButton) {
        presenter.toSwitch()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
