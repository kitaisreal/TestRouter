//
//  TestModelInteractor.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/8/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation

class TestModelInteractor {
    private let testModels:[TestModel]
    init() {
        let firstTestModel = TestModel(testTitle: "firstTest")
        let secondTestModel = TestModel(testTitle: "secondTest")
        let thirdTestModel = TestModel(testTitle: "thirdTest")
        testModels = [firstTestModel, secondTestModel, thirdTestModel]
    }
    func getTestModels() -> [TestModel]{
        return testModels
    }
}
