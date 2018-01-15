//
//  RouteGraphTest.swift
//  DeepLinkTestTests
//
//  Created by Maksim Kita on 1/5/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import XCTest
@testable import DeepLinkTest

class RouteGraphTestTests: XCTestCase {
    let graph = RouteGraph()
    let standartGetType = RouteNodeGetType.storyboard("test")
    let transitionType = RouteTransitionEdgeType(transitionAnimation: TransitionAnimation.yes, transitionData: TransitionData.no)
    
    override func setUp() {
        super.setUp()
        
        let mainNode = RouteNode(routeNodeLink: "/", routeNodeID: "rootNode", routeNodeGetType: standartGetType, routeNodeType: RouterNodeType.navigation)
        let firstChildNode = RouteNode(routeNodeLink: "/firstChild", routeNodeID: "firstChildNode", routeNodeGetType: standartGetType, routeNodeType: RouterNodeType.data)
        let firstChildNodeChild = RouteNode(routeNodeLink: "/firstChild/firstChildNode", routeNodeID: "firstChildNodeChild", routeNodeGetType: standartGetType, routeNodeType: RouterNodeType.data)
        let firstChildNodeChildChild = RouteNode(routeNodeLink: "/firstChild/firstChildNode/firstChildNodeNode", routeNodeID: "firstChildNodeChildChild", routeNodeGetType: standartGetType, routeNodeType: RouterNodeType.data)
        let secondChildNode = RouteNode(routeNodeLink: "/secondChild", routeNodeID: "secondChildNode", routeNodeGetType: standartGetType, routeNodeType: RouterNodeType.data)
        
        mainNode.addEdge(to: firstChildNode, transitionType: transitionType )
        firstChildNode.addEdge(to: firstChildNodeChild, transitionType: transitionType)
        firstChildNodeChild.addEdge(to: firstChildNodeChildChild, transitionType: transitionType)
        firstChildNodeChildChild.addEdge(to: secondChildNode, transitionType: transitionType)
        graph.addNodes(nodes: [mainNode,firstChildNode,secondChildNode,firstChildNodeChild,firstChildNodeChildChild])
    }
    override func tearDown() {
        super.tearDown()
        graph.removeAllNodes()
    }
    func testPathFromSamePoints() {
        let path = graph.findPathToNode(from: "/", to: "/")
        let emptyPath:[RouteNode] = []
        XCTAssertEqual(path.count, emptyPath.count)
    }
    func testPathFromOtherPoints() {
        let path = graph.findPathToNode(from: "/", to: "/firstChild/firstChildNode/firstChildNodeNode")
        XCTAssertEqual(path.count, 3)
    }
    func testPathFromPointsWithoutPathBeetween() {
        let path = graph.findPathToNode(from: "/firstChild/firstChildNode/firstChildNodeNode", to: "/firstChild/firstChildNode")
        XCTAssertEqual(path.count, 0)
    }
    func testPathWhereNoLinksInGraph() {
        let path = graph.findPathToNode(from: "/", to: "/noLink")
        XCTAssertEqual(path.count, 0)
    }
    func testRecursionBug() {
        let node = RouteNode(routeNodeLink: "/first", routeNodeID: "test", routeNodeGetType: standartGetType, routeNodeType: .root)
        node.addEdge(to: node, transitionType: transitionType)
        graph.addNode(node: node)
        let path = graph.findPathToNode(from: "/first", to: "/first")
        XCTAssertEqual(path.count, 0)
    }
}
