//
//  RouterModulePathTestTests.swift
//  DeepLinkTestTests
//
//  Created by Maksim Kita on 1/15/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation
import XCTest
@testable import DeepLinkTest

class RouterModulePathTestTests:XCTestCase {
    let standartGetType = RouteNodeGetType.storyboard("test")
    let standartTransitionEdgeType = RouteTransitionEdgeType(transitionAnimation: .no, transitionData: .no)
    
    private func getModuleForTest() -> RouterModule{
        let firstNode:RouteNode = RouteNode(routeNodeLink: "/", routeNodeID: "testID", routeNodeGetType: standartGetType, routeNodeType: .root)
        let secondNode:RouteNode = RouteNode(routeNodeLink: "/first", routeNodeID: "firstTestID", routeNodeGetType: standartGetType, routeNodeType: .presenter)
        let thirdNode:RouteNode = RouteNode(routeNodeLink: "/second", routeNodeID: "secondTestID", routeNodeGetType: standartGetType, routeNodeType: .presenter)
        firstNode.addEdge(to: secondNode, transitionType: standartTransitionEdgeType)
        secondNode.addEdge(to: thirdNode, transitionType: standartTransitionEdgeType)
        let module:RouterModule = RouterModule(nodes: [firstNode,secondNode,thirdNode], routerModuleRootNode: firstNode)
        return module
    }
    func testModuleLinksGet() {
        let links = ["/","/first","/second"]
        let module = getModuleForTest()
        XCTAssertEqual(links, module.getModuleLinks())
    }
    
    func testPushModulePath() {
        let module = getModuleForTest()
        let path = module.getPathToNode(to: "/first")
        XCTAssertEqual(path.path.count, 1)
        XCTAssertEqual(path.pathType, RouterPathType.push)
        XCTAssertEqual(path.rootNode.routeNodeLink, "/")
    }
    func testRemoveModulePath() {
        let module = getModuleForTest()
        _ = module.getPathToNode(to: "/second")
        let path = module.getPathToNode(to: "/")
        XCTAssertEqual(path.path.count, 0)
        XCTAssertEqual(path.pathType, RouterPathType.remove(2))
        XCTAssertEqual(path.rootNode.routeNodeLink, "/")
    }
    func testCurrentLinkModulePath() {
        let module:RouterModule = getModuleForTest()
        _ = module.getPathToNode(to: "/second")
        let path = module.getPathToNode(to: "/second")
        print("PATH \(path.path.count) \(path.pathType) \(path.rootNode.routeNodeLink)")
        XCTAssertEqual(path.path.count, 0)
        XCTAssertEqual(path.pathType, RouterPathType.currentLink)
        XCTAssertEqual(path.rootNode.routeNodeLink, "/")
    }
    func testEmptyModulePath() {
        let module:RouterModule = getModuleForTest()
        let path = module.getPathToNode(to: "/something")
        print("PATH \(path.path.count) \(path.pathType) \(path.rootNode.routeNodeLink)")
        XCTAssertEqual(path.path.count, 0)
        XCTAssertEqual(path.pathType, RouterPathType.empty)
        XCTAssertEqual(path.rootNode.routeNodeLink, "/")
    }
    func testBackInModule() {
        let module:RouterModule = getModuleForTest()
        _ = module.getPathToNode(to: "/second")
        module.getBackInModule()
        module.getBackInModule()
        path = module.getPathToNode(to: "/")
        
    }
    func testRouterPathTypesEnum() {
        XCTAssertEqual(RouterPathType.push == RouterPathType.push, true)
        XCTAssertEqual(RouterPathType.push != RouterPathType.currentLink, true)
        XCTAssertEqual(RouterPathType.push != RouterPathType.empty, true)
        XCTAssertEqual(RouterPathType.remove(5) == RouterPathType.remove(5), true)
        XCTAssertEqual(RouterPathType.remove(4) != RouterPathType.remove(5), true)
    }
}
