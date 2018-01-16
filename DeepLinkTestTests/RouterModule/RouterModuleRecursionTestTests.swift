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
    
    func testRouterModulesCompare() {
        print("SELF COUNT STARTED ROUTER MODULES COMPARE")
        print("TEST ROUTER MODULE COMPARE")
        let module = getModuleForTests()
        module.addChildsRouterModules(routerModule: [getSecondModuleForTests()])
        let secondModule = getModuleForTests()
        secondModule.addChildsRouterModules(routerModule: [getThirdModuleForTests()])
        if (module == secondModule) {
            print("COMPARED")
        }
    }
}
