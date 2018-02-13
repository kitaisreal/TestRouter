//
//  RouterModuleRecursionTestTests.swift
//  DeepLinkTestTests
//
//  Created by Maksim Kita on 1/15/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation
import XCTest
@testable import DeepLinkTest

class RouterModuleRecursionTestTests:XCTestCase {
    let standartGetType = RouteNodeGetType.storyboard("test")
    let standartTransitionEdgeType = RouteTransitionEdgeType(transitionAnimation: .no, transitionData: .no)
    
    private func getModuleForTests() -> RouterModule {
        let firstNode:RouteNode = RouteNode(routeNodeLink: "/", routeNodeID: "testID", routeNodeGetType: standartGetType, routeNodeTypes: [.root])
        let secondNode:RouteNode = RouteNode(routeNodeLink: "/first", routeNodeID: "firstTestID", routeNodeGetType: standartGetType, routeNodeTypes: [.presenter])
        let thirdNode:RouteNode = RouteNode(routeNodeLink: "/second", routeNodeID: "secondTestID", routeNodeGetType: standartGetType, routeNodeTypes: [.presenter])
        firstNode.addEdge(to: secondNode, transitionType: standartTransitionEdgeType)
        secondNode.addEdge(to: thirdNode, transitionType: standartTransitionEdgeType)
        let module:RouterModule = RouterModule(nodes: [firstNode,secondNode,thirdNode], routerModuleRootNode: firstNode)
        return module
    }
    private func getSecondModuleForTests() -> RouterModule {
        let firstNode:RouteNode = RouteNode(routeNodeLink: "/secondModuleRoot", routeNodeID: "testID", routeNodeGetType: standartGetType, routeNodeTypes: [.root])
        let module:RouterModule = RouterModule(nodes: [firstNode], routerModuleRootNode: firstNode)
        return module
    }
    private func getThirdModuleForTests() -> RouterModule {
        let firstNode:RouteNode = RouteNode(routeNodeLink: "/thirdModuleRoot", routeNodeID: "testID", routeNodeGetType: standartGetType, routeNodeTypes: [.root])
        let module:RouterModule = RouterModule(nodes: [firstNode], routerModuleRootNode: firstNode)
        return module
    }
    
    func testRouterModulesSameCompare() {
        let firstModule = getModuleForTests()
        let secondModule = getModuleForTests()
        XCTAssertEqual(firstModule == secondModule, true)
    }
    
    func testRouterModulesDifferentCompare() {
        let firstModule = getModuleForTests()
        let secondModule = getSecondModuleForTests()
        XCTAssertEqual(firstModule == secondModule, false)
    }
    
    func testRouterModuleDifferentWithOtherSubmoduleCompare() {
        let firstModule = getModuleForTests()
        let secondModule = getModuleForTests()
        firstModule.addChildRouterModule(routerModule: getSecondModuleForTests())
        secondModule.addChildRouterModule(routerModule: getThirdModuleForTests())
        XCTAssertEqual(firstModule == secondModule, false)
    }
    
    func testRouterModuleAddSameModule() {
        let firstModule = getModuleForTests()
        firstModule.addChildRouterModule(routerModule: firstModule)
        let firstModuleModules = firstModule.getModuleModules()
        XCTAssertEqual(firstModuleModules.count, 1)
    }
    
    func testRouterModuleAddDifferentModule() {
        let firstModule = getModuleForTests()
        let secondModule = getSecondModuleForTests()
        firstModule.addChildRouterModule(routerModule: secondModule)
        let firstModuleModules = firstModule.getModuleModules()
        XCTAssertEqual(firstModuleModules.count, 2)
    }
    
}
