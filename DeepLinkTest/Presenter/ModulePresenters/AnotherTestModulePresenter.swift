//
//  AnotherTestModulePresenter.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/8/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation

class AnotherTestModulePresenter:RouterSenderProtocol {
    
    func sendDataWithLink(link:String, data:String) {
        MainRouter.instance.navigateToLink(link: link, data: data, sender:self)
    }
}
