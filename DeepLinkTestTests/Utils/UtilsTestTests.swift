//
//  UtilsTestTests.swift
//  DeepLinkTestTests
//
//  Created by Maksim Kita on 1/15/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation
import XCTest
@testable import DeepLinkTest

class UtilsTestTests:XCTestCase {
    func testArrayFullElementsCompareWrongCount()  {
        let firstArray = [1,3,2]
        let secondArray = [3,2,1,4,5]
        XCTAssertEqual(firstArray.compare(with: secondArray), secondArray.compare(with: firstArray))
        XCTAssertEqual(firstArray.compare(with: secondArray), false)
    }
    func testArrayFullElementsCompare() {
        let firstArray = [1,2,3]
        let secondArray = [3,1,2]
        XCTAssertEqual(firstArray.compare(with: secondArray), secondArray.compare(with: firstArray))
        XCTAssertEqual(firstArray.compare(with: firstArray), firstArray.compare(with: firstArray))
        XCTAssertEqual(firstArray.compare(with: secondArray), true)
        XCTAssertEqual(firstArray.compare(with: firstArray), true)
    }
}
