//
//  TestModuleInteractor.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/11/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation

class MainModuleInteractor {
    private var mainModelArray:[MainModuleModel] = []
    
    init() {
        mainModelArray.append(MainModuleModel(testTitle: "FirstModel"))
        mainModelArray.append(MainModuleModel(testTitle: "SecondModel"))
        mainModelArray.append(MainModuleModel(testTitle: "ThirdModel"))
    }
    func getModels() -> [MainModuleModel] {
        return mainModelArray
    }
}
