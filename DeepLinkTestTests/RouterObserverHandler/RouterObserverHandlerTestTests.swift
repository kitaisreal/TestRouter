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

class RouterObserverHandlerTestTests:XCTestCase {
    
    func testActionsAdd() {
        let routerObserverHandler = RouterObserverHandler()
        routerObserverHandler.addObserver(link: "testLinkFirst", id: "testID1", linkType: RouterObserverLinkType.modulePresent) {
            XCTAssertEqual(true, true)
        }
        routerObserverHandler.addObserver(link: "testLinkFirst", id: "testID2", linkType: RouterObserverLinkType.modulePresent) {
            XCTAssertEqual(true, true)
        }
        routerObserverHandler.addObserver(link: "testLinkSecond", id: "testID2", linkType: RouterObserverLinkType.modulePresent) {
            XCTAssertEqual(true, true)
        }
        routerObserverHandler.addObserver(link: "testLinkSecond", id: "testID3", linkType: RouterObserverLinkType.modulePresent) {
            XCTAssertEqual(true, true)
        }
        routerObserverHandler.addObserver(link: "testLinkFirst", id: "testID1", linkType: RouterObserverLinkType.moduleRemove) {
            XCTAssertEqual(true, true)
        }
        routerObserverHandler.makeAction(with: "testLinkFirst", by: RouterObserverLinkType.modulePresent)
        routerObserverHandler.makeAction(with: "testLinkSecond", by: RouterObserverLinkType.modulePresent)
        routerObserverHandler.makeAction(with: "testLinkFirst", by: RouterObserverLinkType.moduleRemove)
    }
    func testAllActionsRemove() {
        let routerObserverHandler = RouterObserverHandler()
        routerObserverHandler.addObserver(link: "testLinkFirst", id: "testID1", linkType: RouterObserverLinkType.modulePresent) {
            XCTFail()
        }
        routerObserverHandler.addObserver(link: "testLinkFirst", id: "testID2", linkType: RouterObserverLinkType.modulePresent) {
            XCTFail()
        }
        routerObserverHandler.addObserver(link: "testLinkSecond", id: "testID2", linkType: RouterObserverLinkType.modulePresent) {
            XCTFail()
        }
        routerObserverHandler.addObserver(link: "testLinkSecond", id: "testID3", linkType: RouterObserverLinkType.modulePresent) {
            XCTFail()
        }
        routerObserverHandler.addObserver(link: "testLinkFirst", id: "testID1", linkType: RouterObserverLinkType.moduleRemove) {
            XCTFail()
        }
        routerObserverHandler.removeAllObservers()
        routerObserverHandler.makeAction(with: "testLinkFirst", by: RouterObserverLinkType.modulePresent)
        routerObserverHandler.makeAction(with: "testLinkSecond", by: RouterObserverLinkType.modulePresent)
        routerObserverHandler.makeAction(with: "testLinkFirst", by: RouterObserverLinkType.moduleRemove)
        routerObserverHandler.makeAction(with: "testLinkFirst", by: RouterObserverLinkType.modulePresent)
        XCTAssertEqual(true, true)
    }
    func testActionsRemoveByLink() {
        let routerObserverHandler = RouterObserverHandler()
        routerObserverHandler.addObserver(link: "testLinkFirst", id: "testID1", linkType: RouterObserverLinkType.modulePresent) {
            XCTFail()
        }
        routerObserverHandler.addObserver(link: "testLinkFirst", id: "testID2", linkType: RouterObserverLinkType.modulePresent) {
            XCTFail()
        }
        routerObserverHandler.addObserver(link: "testLinkSecond", id: "testID2", linkType: RouterObserverLinkType.modulePresent) {
            XCTFail()
        }
        routerObserverHandler.addObserver(link: "testLinkSecond", id: "testID3", linkType: RouterObserverLinkType.modulePresent) {
            XCTFail()
        }
        routerObserverHandler.addObserver(link: "testLinkFirst", id: "testID1", linkType: RouterObserverLinkType.moduleRemove) {
            XCTAssertEqual(true, true)
        }
        routerObserverHandler.removeObservers(by: RouterObserverLinkType.modulePresent)
        routerObserverHandler.makeAction(with: "testLinkFirst", by: RouterObserverLinkType.modulePresent)
        routerObserverHandler.makeAction(with: "testLinkSecond", by: RouterObserverLinkType.modulePresent)
        routerObserverHandler.makeAction(with: "testLinkFirst", by: RouterObserverLinkType.moduleRemove)
        routerObserverHandler.makeAction(with: "testLinkFirst", by: RouterObserverLinkType.modulePresent)
        XCTAssertEqual(true, true)
    }
    func testActionsRemoveByLinkType() {
        let routerObserverHandler = RouterObserverHandler()
        routerObserverHandler.addObserver(link: "testLinkFirst", id: "testID1", linkType: RouterObserverLinkType.modulePresent) {
            XCTAssertEqual(true, true)
        }
        routerObserverHandler.addObserver(link: "testLinkFirst", id: "testID2", linkType: RouterObserverLinkType.modulePresent) {
            XCTAssertEqual(true, true)
        }
        routerObserverHandler.addObserver(link: "testLinkSecond", id: "testID2", linkType: RouterObserverLinkType.modulePresent) {
            XCTFail()
        }
        routerObserverHandler.addObserver(link: "testLinkSecond", id: "testID3", linkType: RouterObserverLinkType.modulePresent) {
            XCTFail()
        }
        routerObserverHandler.addObserver(link: "testLinkFirst", id: "testID1", linkType: RouterObserverLinkType.moduleRemove) {
            XCTAssertEqual(true, true)
        }
        routerObserverHandler.removeObservers(linkType: RouterObserverLinkType.modulePresent, link: "testLinkSecond")
        routerObserverHandler.makeAction(with: "testLinkFirst", by: RouterObserverLinkType.modulePresent)
        routerObserverHandler.makeAction(with: "testLinkSecond", by: RouterObserverLinkType.modulePresent)
        routerObserverHandler.makeAction(with: "testLinkFirst", by: RouterObserverLinkType.moduleRemove)
        routerObserverHandler.makeAction(with: "testLinkFirst", by: RouterObserverLinkType.modulePresent)
        XCTAssertEqual(true, true)
    }
    func testActionsRemoveByLinkID() {
        let routerObserverHandler = RouterObserverHandler()
        routerObserverHandler.addObserver(link: "testLinkFirst", id: "testID1", linkType: RouterObserverLinkType.modulePresent) {
            XCTAssertEqual(true, true)
        }
        routerObserverHandler.addObserver(link: "testLinkFirst", id: "testID2", linkType: RouterObserverLinkType.modulePresent) {
            XCTAssertEqual(true, true)
        }
        routerObserverHandler.addObserver(link: "testLinkSecond", id: "testID2", linkType: RouterObserverLinkType.modulePresent) {
            XCTAssertEqual(true, true)
        }
        routerObserverHandler.addObserver(link: "testLinkSecond", id: "testID3", linkType: RouterObserverLinkType.modulePresent) {
            XCTFail()
        }
        routerObserverHandler.addObserver(link: "testLinkFirst", id: "testID1", linkType: RouterObserverLinkType.moduleRemove) {
            XCTAssertEqual(true, true)
        }
        routerObserverHandler.removeObserver(linkType: RouterObserverLinkType.modulePresent, link: "testLinkSecond", id: "testID3")
        routerObserverHandler.makeAction(with: "testLinkFirst", by: RouterObserverLinkType.modulePresent)
        routerObserverHandler.makeAction(with: "testLinkSecond", by: RouterObserverLinkType.modulePresent)
        routerObserverHandler.makeAction(with: "testLinkFirst", by: RouterObserverLinkType.moduleRemove)
        routerObserverHandler.makeAction(with: "testLinkFirst", by: RouterObserverLinkType.modulePresent)
        XCTAssertEqual(true, true)
    }
    func testActionsGetLinks() {
        let routerObserverHandler = RouterObserverHandler()
        routerObserverHandler.addObserver(link: "testLinkFirst", id: "testID1", linkType: RouterObserverLinkType.modulePresent) {
            XCTAssertEqual(true, true)
        }
        routerObserverHandler.addObserver(link: "testLinkFirst", id: "testID2", linkType: RouterObserverLinkType.modulePresent) {
            XCTAssertEqual(true, true)
        }
        routerObserverHandler.addObserver(link: "testLinkSecond", id: "testID2", linkType: RouterObserverLinkType.modulePresent) {
            XCTAssertEqual(true, true)
        }
        routerObserverHandler.addObserver(link: "testLinkSecond", id: "testID3", linkType: RouterObserverLinkType.modulePresent) {
            XCTFail()
        }
        routerObserverHandler.addObserver(link: "testLinkFirst", id: "testID1", linkType: RouterObserverLinkType.moduleRemove) {
            XCTAssertEqual(true, true)
        }
        let firstLinks = routerObserverHandler.getAllLinks(by: RouterObserverLinkType.modulePresent)
        let secondLinks = routerObserverHandler.getAllLinks(by: RouterObserverLinkType.moduleRemove)
        let thirdLinks = routerObserverHandler.getAllLinks(by: RouterObserverLinkType.moduleNavigation)
        let firstLinksToCompare = ["testLinkFirst", "testLinkSecond"]
        let secondLinksToCompare = ["testLinkFirst"]
        XCTAssertEqual(firstLinks.compare(with: firstLinksToCompare), true)
        XCTAssertEqual(secondLinks.compare(with: secondLinksToCompare), true)
        XCTAssertEqual(thirdLinks.count == 0, true)
    }
}

