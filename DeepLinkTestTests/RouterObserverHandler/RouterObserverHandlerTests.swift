//
//  RouterObserverHandlerTests.swift
//  DeepLinkTestTests
//
//  Created by Maksim Kita on 1/12/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation
import XCTest
@testable import DeepLinkTest

class RouterObserverHandlertests:XCTest {
    func testSomething() {
        let routerObserverHandler = RouterObserverHandler()
        routerObserverHandler.addObserver(link: "/testLink", id: "testID1") {
            print("TESTIDACTION TEST ID 1")
        }
        routerObserverHandler.addObserver(link: "/testLink", id: "testID2") {
            print("TESTIDACTION TEST ID 2")
        }
        routerObserverHandler.addObserver(link: "/anotherTestLink", id: "anotherTestID") {
            print("AnotherTestIDAACTION")
        }
        print(routerObserverHandler.getLinks())
        routerObserverHandler.makeAction(link: "/testLink")
        routerObserverHandler.makeAction(link: "/anotherTestLink")
    }
    func test() {
        print("TEST")
        XCTAssertEqual(false, true)
    }
}
