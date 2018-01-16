//
//  RouterModuleLinksTestTests.swift
//  DeepLinkTestTests
//
//  Created by Maksim Kita on 1/15/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation
import XCTest
@testable import DeepLinkTest

class RouterModuleLinksTestTests:XCTestCase {

    let standartGetType = RouteNodeGetType.storyboard("test")
    let standartTransitionEdgeType = RouteTransitionEdgeType(transitionAnimation: .no, transitionData: .no)
    
    private func getModuleForTests() -> RouterModule {
        let firstNode:RouteNode = RouteNode(routeNodeLink: "/", routeNodeID: "testID", routeNodeGetType: standartGetType, routeNodeType: .root)
        let secondNode:RouteNode = RouteNode(routeNodeLink: "/first", routeNodeID: "firstTestID", routeNodeGetType: standartGetType, routeNodeType: .presenter)
        let thirdNode:RouteNode = RouteNode(routeNodeLink: "/second", routeNodeID: "secondTestID", routeNodeGetType: standartGetType, routeNodeType: .presenter)
        firstNode.addEdge(to: secondNode, transitionType: standartTransitionEdgeType)
        secondNode.addEdge(to: thirdNode, transitionType: standartTransitionEdgeType)
        let module:RouterModule = RouterModule(nodes: [firstNode,secondNode,thirdNode], routerModuleRootNode: firstNode)
        return module
    }
    private func getSecondModuleForTests() -> RouterModule {
        let firstNode:RouteNode = RouteNode(routeNodeLink: "/secondModuleRoot", routeNodeID: "testID", routeNodeGetType: standartGetType, routeNodeType: .root)
        let module:RouterModule = RouterModule(nodes: [firstNode], routerModuleRootNode: firstNode)
        return module
    }
    private func getThirdModuleForTests() -> RouterModule {
        let firstNode:RouteNode = RouteNode(routeNodeLink: "/thirdModuleRoot", routeNodeID: "testID", routeNodeGetType: standartGetType, routeNodeType: .root)
        let module:RouterModule = RouterModule(nodes: [firstNode], routerModuleRootNode: firstNode)
        return module
    }
    func testGetLinks() {
        let module = getModuleForTests()
        let links = ["/", "/first", "/second"]
        XCTAssertEqual(module.getModuleLinks(), links)
    }
    
    func testGetModuleLinks() {
        let links = ["/", "/first", "/second","/secondModuleRoot","/thirdModuleRoot"]
        let module = getModuleForTests()
        let secondModule = getSecondModuleForTests()
        let thirdModule = getThirdModuleForTests()
        secondModule.addChildsRouterModules(routerModule: [thirdModule])
        module.addChildsRouterModules(routerModule: [secondModule])
        let moduleLinks = module.getModuleAllLinks()
        print(moduleLinks)
        XCTAssertEqual(moduleLinks.compare(with: links), true)
    }
    func testGetModuleRootLinks() {
        let links = ["/", "/secondModuleRoot", "/thirdModuleRoot"]
        let module = getModuleForTests()
        let secondModule = getSecondModuleForTests()
        let thirdModule = getThirdModuleForTests()
        module.addChildsRouterModules(routerModule: [secondModule,thirdModule])
        let moduleRootLinks = module.getModuleAllRootsLinks()
        print(moduleRootLinks)
        XCTAssertEqual(moduleRootLinks.compare(with: links), true)
    }
    
}
