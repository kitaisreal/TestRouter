//
//  RouteGraphCompareTestTests.swift
//  DeepLinkTestTests
//
//  Created by Maksim Kita on 1/16/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation
import XCTest
@testable import DeepLinkTest

class RouteGraphCompareTestTests:XCTestCase {
    
    let standartGetType = RouteNodeGetType.storyboard("test")
    let transitionType = RouteTransitionEdgeType(transitionAnimation: TransitionAnimation.yes, transitionData: TransitionData.no)
    
    func getGraphForTest() -> RouteGraph {
        let graph = RouteGraph()
        let mainNode = RouteNode(routeNodeLink: "/", routeNodeID: "rootNode", routeNodeGetType: standartGetType, routeNodeTypes: [RouterNodeType.navigation])
        let firstChildNode = RouteNode(routeNodeLink: "/firstChild", routeNodeID: "firstChildNode", routeNodeGetType: standartGetType, routeNodeTypes: [RouterNodeType.data])
        let firstChildNodeChild = RouteNode(routeNodeLink: "/firstChild/firstChildNode", routeNodeID: "firstChildNodeChild", routeNodeGetType: standartGetType, routeNodeTypes: [RouterNodeType.data])
        let firstChildNodeChildChild = RouteNode(routeNodeLink: "/firstChild/firstChildNode/firstChildNodeNode", routeNodeID: "firstChildNodeChildChild", routeNodeGetType: standartGetType, routeNodeTypes: [RouterNodeType.data])
        let secondChildNode = RouteNode(routeNodeLink: "/secondChild", routeNodeID: "secondChildNode", routeNodeGetType: standartGetType, routeNodeTypes: [RouterNodeType.data])
        
        mainNode.addEdge(to: firstChildNode, transitionType: transitionType )
        firstChildNode.addEdge(to: firstChildNodeChild, transitionType: transitionType)
        firstChildNodeChild.addEdge(to: firstChildNodeChildChild, transitionType: transitionType)
        firstChildNodeChildChild.addEdge(to: secondChildNode, transitionType: transitionType)
        graph.addNodes(nodes: [mainNode,firstChildNode,secondChildNode,firstChildNodeChild,firstChildNodeChildChild])
        return graph
    }
    
    func testGraphCompare() {
        let graph = getGraphForTest()
        let otherGraph = getGraphForTest()
        XCTAssertEqual(graph == otherGraph, true)
    }
    func testGraphLinksCompare() {
        let graph = getGraphForTest()
        let otherGraph = getGraphForTest()
        XCTAssertEqual(graph.getLinks() == otherGraph.getLinks(), true)
    }
    func testDifferentGraphCompare() {
        let graph = getGraphForTest()
        let secondGraph  = getGraphForTest()
        let differentNode = RouteNode(routeNodeLink: "/differentNode", routeNodeID: "testID", routeNodeGetType: standartGetType, routeNodeTypes: [.root])
        secondGraph.addNode(node: differentNode)
        XCTAssertEqual(graph == secondGraph, false)
    }
    func testDifferentGraphLinksCompare() {
        let graph = getGraphForTest()
        let secondGraph  = getGraphForTest()
        let differentNode = RouteNode(routeNodeLink: "/differentNode", routeNodeID: "testID", routeNodeGetType: standartGetType, routeNodeTypes: [.root])
        secondGraph.addNode(node: differentNode)
        XCTAssertEqual(graph.getLinks() == secondGraph.getLinks(), false)
    }
}
