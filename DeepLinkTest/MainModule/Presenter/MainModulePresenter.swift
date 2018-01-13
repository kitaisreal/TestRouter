//
//  TestModulePresenter.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/8/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation

class MainModulePresenter {
    private let testModuleInteractor:MainModuleInteractor
    
    init() {
        testModuleInteractor = MainModuleInteractor()
    }
    func getModelData() -> [MainModuleModel] {
        return testModuleInteractor.getModels()
    }
    func setDataWithLink(testModel:MainModuleModel) {
        MainRouter.instance.navigate(to: "*/detail", data: testModel)
    }
    func toSwitch() {
        MainRouter.instance.configureModule(with: "/switch")
        MainRouter.instance.presentModule(with: "/switch", data:"Test Data")
    }
}
