//
//  RouteNodeTypesTestTests.swift
//  DeepLinkTestTests
//
//  Created by Maksim Kita on 1/16/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation
import XCTest
@testable import DeepLinkTest

class RouteNodeTypesTestTests:XCTestCase {
    
    let standartGetType = RouteNodeGetType.storyboard("test")
    
    func testTrueNodeTypes() {
        let routeNode = RouteNode(routeNodeLink: "/", routeNodeID: "test", routeNodeGetType: standartGetType, routeNodeTypes: [.root, .navigation, .presenter])
        XCTAssertEqual(routeNode.isRoot, true)
        XCTAssertEqual(routeNode.isNavigation, true)
        XCTAssertEqual(routeNode.isPresenter, true)
    }
    func testFalseNodeTypes() {
        let routeNode = RouteNode(routeNodeLink: "/", routeNodeID: "test", routeNodeGetType: standartGetType, routeNodeTypes: [.root, .navigation, .presenter])
        XCTAssertEqual(routeNode.isContainer, false)
        XCTAssertEqual(routeNode.isData, false)
        XCTAssertEqual(routeNode.isSubmodule, false)
    }
}
