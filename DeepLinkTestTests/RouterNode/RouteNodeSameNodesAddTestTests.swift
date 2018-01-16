//
//  RouteNodeSameNodesAdd.swift
//  DeepLinkTestTests
//
//  Created by Maksim Kita on 1/16/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation
import XCTest
@testable import DeepLinkTest

class RouteNodeSameNodesAddTestTests:XCTestCase {
    
    let standartGetType = RouteNodeGetType.storyboard("test")
    let defaultTransitionType = RouteTransitionEdgeType(transitionAnimation: .no, transitionData: .no)
    
    func testRouteNodeAddSameNodeInContainer() {
        let firstRouteNode = RouteNode(routeNodeLink: "/", routeNodeID: "testID", routeNodeGetType: standartGetType, routeNodeTypes: [.root])
        let secondRouteNode = RouteNode(routeNodeLink: "/", routeNodeID: "testID", routeNodeGetType: standartGetType, routeNodeTypes: [.root])
        firstRouteNode.addNodesToContainer(routeNodes: [secondRouteNode])
        XCTAssertEqual(firstRouteNode.containerForNodes.count, 0)
        firstRouteNode.addNodesToContainer(routeNodes: [firstRouteNode])
        XCTAssertEqual(firstRouteNode.containerForNodes.count, 0)
    }
    func testRouteNodeAddSameNodeToEdge() {
        let firstRouteNode = RouteNode(routeNodeLink: "/", routeNodeID: "testID", routeNodeGetType: standartGetType, routeNodeTypes: [.root])
        let secondRouteNode = RouteNode(routeNodeLink: "/", routeNodeID: "testID", routeNodeGetType: standartGetType, routeNodeTypes: [.root])
        firstRouteNode.addEdge(to: secondRouteNode, transitionType: defaultTransitionType)
        XCTAssertEqual(firstRouteNode.adjacentEdges.count, 0)
        firstRouteNode.addEdge(to: firstRouteNode, transitionType: defaultTransitionType)
        XCTAssertEqual(firstRouteNode.adjacentEdges.count, 0)
    }
}
