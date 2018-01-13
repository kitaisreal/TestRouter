//
//  AnotherTestModulePresenter.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/8/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation

class AnotherTestModulePresenter {
    
    func sendDataWithLink(link:String, data:String) {
        MainRouter.instance.navigate(to: link, data: data)
    }
}
