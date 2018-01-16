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

class RouterObserverHandlertests:XCTestCase {
    
    func testHashTable() {
        let routerObserverHandler = RouterObserverHandler()
        routerObserverHandler.addObserver(link: "testLinkFirst", id: "testID1", linkType: RouterObserverLinkType.modulePresent) {
            print("TEST LINK FIRST WITH ID TESTID1 IN MODULE PRESENT")
        }
        routerObserverHandler.addObserver(link: "testLinkFirst", id: "testID2", linkType: RouterObserverLinkType.modulePresent) {
            print("TEST LINK FIRST WITH ID TESTID2 IN MODULE PRESENT")
        }
        routerObserverHandler.addObserver(link: "testLinkSecond", id: "testID2", linkType: RouterObserverLinkType.modulePresent) {
            print("TEST LINK SECOND WITH ID TESTID2 IN MODULE PRESENT")
        }
        routerObserverHandler.addObserver(link: "testLinkSecond", id: "testID3", linkType: RouterObserverLinkType.modulePresent) {
            print("TEST LINK SECOND WITH ID TESTID3 IN MODULE PRESENT")
        }
        routerObserverHandler.addObserver(link: "testLinkFirst", id: "testID1", linkType: RouterObserverLinkType.moduleRemove) {
            print("TEST LINK FIRST WITH ID TESTID1 IN MODULE REMOVE")
        }
        routerObserverHandler.makeAction(with: "testLinkFirst", by: RouterObserverLinkType.modulePresent)
        routerObserverHandler.makeAction(with: "testLinkSecond", by: RouterObserverLinkType.modulePresent)
        routerObserverHandler.makeAction(with: "testLinkFirst", by: RouterObserverLinkType.moduleRemove)
        let links = routerObserverHandler.getAllLinks(by: RouterObserverLinkType.moduleRemove)
        print(links)
    }
}

