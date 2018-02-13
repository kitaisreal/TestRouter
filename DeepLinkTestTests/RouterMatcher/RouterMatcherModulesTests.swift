//
//  RouterMatcherModulesTest.swift
//  DeepLinkTestTests
//
//  Created by Maksim Kita on 1/11/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import XCTest
@testable import DeepLinkTest

class RouterMatcherModuleTests:XCTestCase {
    let getTypeDefault = RouteNodeGetType.storyboard("test")
    let matcher = Matcher()
    
    func testRouterModulesMatch() {
        let node = RouteNode(routeNodeLink: "/", routeNodeID: "test", routeNodeGetType: getTypeDefault, routeNodeTypes: [.root])
        let otherNode = RouteNode(routeNodeLink: "/test", routeNodeID: "otherTest", routeNodeGetType: getTypeDefault, routeNodeTypes: [.root])
        let routerModule = RouterModule(nodes: [node,otherNode], routerModuleRootNode: node)
        let otherRouterModule = RouterModule(nodes: [node], routerModuleRootNode: node)
        let matcherResponse = matcher.getModuleWithLink(with: "*st", from: [routerModule, otherRouterModule])
        XCTAssertEqual(matcherResponse!.routerModule.routerModuleRootNode.routeNodeLink, routerModule.routerModuleRootNode.routeNodeLink)
        XCTAssertEqual(matcherResponse!.link, "/test")
        let otherMatcherResponse = matcher.getModuleWithLink(with: "/test", from: [otherRouterModule])
        if (otherMatcherResponse == nil) {
            XCTAssertEqual(true, true)
        }
    }
    
    
}
