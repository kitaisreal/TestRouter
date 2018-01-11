//
//  TestModulePresenter.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/8/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation

class MainModulePresenter:RouterSenderProtocol {
    private let testModuleInteractor:MainModuleInteractor
    
    init() {
        testModuleInteractor = MainModuleInteractor()
    }
    func getModelData() -> [MainModuleModel] {
        return testModuleInteractor.getModels()
    }
    func setDataWithLink(testModel:MainModuleModel) {
        MainRouter.instance.navigateToLink(link: "*/detail", data: testModel, sender:self)
    }
}
