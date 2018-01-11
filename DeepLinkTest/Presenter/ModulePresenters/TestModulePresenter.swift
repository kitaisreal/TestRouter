//
//  TestModulePresenter.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/8/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation

class TestModulePresenter:RouterSenderProtocol {
    private let testModuleInteractor:TestModelInteractor
    
    init() {
        testModuleInteractor = TestModelInteractor()
    }
    func getModelData() -> [TestModel] {
        return testModuleInteractor.getTestModels()
    }
    func setDataWithLink(testModel:TestModel) {
        MainRouter.instance.navigateToLink(link: "*/detail", data: testModel, sender:self)
    }
}
