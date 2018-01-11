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
    
    override func setUp() {
        super.setUp()
        let mainNode = RouteNode(routeNodeLink: "/", routeNodeID: "rootNode", routeNodeType: RouteNodeType.navigation)
        let firstChildNode = RouteNode(routeNodeLink: "/firstChild", routeNodeID: "firstChildNode", routeNodeType: RouteNodeType.data)
        let firstChildNodeChild = RouteNode(routeNodeLink: "/firstChild/firstChildNode", routeNodeID: "firstChildNodeChild", routeNodeType: RouteNodeType.data)
        let firstChildNodeChildChild = RouteNode(routeNodeLink: "/firstChild/firstChildNode/firstChildNodeNode", routeNodeID: "firstChildNodeChildChild", routeNodeType: RouteNodeType.data)
        let secondChildNode = RouteNode(routeNodeLink: "/secondChild", routeNodeID: "secondChildNode", routeNodeType: RouteNodeType.data)
        let transitionType = RouteTransitionEdgeType(transitionAnimation: TransitionAnimation.yes, transitionData: TransitionData.no)
        
        mainNode.addEdge(to: firstChildNode, transitionType: transitionType )
        firstChildNode.addEdge(to: firstChildNodeChild, transitionType: transitionType)
        firstChildNodeChild.addEdge(to: firstChildNodeChildChild, transitionType: transitionType)
        firstChildNodeChildChild.addEdge(to: secondChildNode, transitionType: transitionType)
        
        graph.addNode(node: mainNode)
        graph.addNode(node: firstChildNode)
        graph.addNode(node: secondChildNode)
        graph.addNode(node: firstChildNodeChild)
        graph.addNode(node: firstChildNodeChildChild)
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
}
