//
//  RouteNodeTestTests.swift
//  DeepLinkTestTests
//
//  Created by Maksim Kita on 1/15/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation
import XCTest
@testable import DeepLinkTest

class RouterNodeTestTests:XCTestCase {
    let standartGetType = RouteNodeGetType.storyboard("test")
    let standartTransitionEdgeType = RouteTransitionEdgeType(transitionAnimation: .no, transitionData: .no)
    
    func testRouterNodeComparable() {
        let notStandartGetType = RouteNodeGetType.storyboard("something")
        let routeNodeFirst = RouteNode(routeNodeLink: "/", routeNodeID: "testID", routeNodeGetType: standartGetType, routeNodeType: .root)
        let routeNodeSecond = RouteNode(routeNodeLink: "/", routeNodeID: "testID", routeNodeGetType: standartGetType, routeNodeType: .root)
        let routeNodeThird = RouteNode(routeNodeLink: "/some", routeNodeID: "testID", routeNodeGetType: standartGetType, routeNodeType: .root)
        let routeNodeFourth = RouteNode(routeNodeLink: "/some", routeNodeID: "testID", routeNodeGetType: standartGetType, routeNodeType: .navigation)
        let routeNodeFifth = RouteNode(routeNodeLink: "/some", routeNodeID: "testIDs", routeNodeGetType: standartGetType, routeNodeType: .presenter)
        let routeNodeSixth = RouteNode(routeNodeLink: "/some", routeNodeID: "testIDs", routeNodeGetType: notStandartGetType, routeNodeType: .presenter)
        let routeNodeSeventh = RouteNode(routeNodeLink: "/some", routeNodeID: "testIDs", routeNodeGetType: notStandartGetType, routeNodeType: .presenter)
        XCTAssertEqual(routeNodeFirst == routeNodeSecond , true)
        XCTAssertEqual(routeNodeFirst == routeNodeThird, false)
        XCTAssertEqual(routeNodeThird == routeNodeFourth, false)
        XCTAssertEqual(routeNodeFourth == routeNodeFifth, false)
        XCTAssertEqual(routeNodeFifth == routeNodeSixth, true)
        XCTAssertEqual(routeNodeSixth == routeNodeSeventh, true)
    }
    
    func testRouterNodesCompares() {
        let routeNodeFirst = RouteNode(routeNodeLink: "/", routeNodeID: "testID", routeNodeGetType: standartGetType, routeNodeType: .root)
        let routeNodeSecond = RouteNode(routeNodeLink: "/", routeNodeID: "testID", routeNodeGetType: standartGetType, routeNodeType: .root)
        let routeNodeThird = RouteNode(routeNodeLink: "/some", routeNodeID: "testID", routeNodeGetType: standartGetType, routeNodeType: .root)
        let routeNodeFourth = RouteNode(routeNodeLink: "/some", routeNodeID: "testID", routeNodeGetType: standartGetType, routeNodeType: .navigation)
        let firstNodeArray = [routeNodeFirst, routeNodeSecond, routeNodeThird]
        let secondNodeArray = [routeNodeThird, routeNodeFirst, routeNodeSecond]
        let thirdNodeArray = [routeNodeFirst, routeNodeSecond, routeNodeFourth]
        let fourthNodeArray = [routeNodeFirst, routeNodeSecond, routeNodeFourth]
        XCTAssertEqual(firstNodeArray.compare(with: secondNodeArray), true)
        XCTAssertEqual(firstNodeArray.compare(with: thirdNodeArray), false)
        XCTAssertEqual(thirdNodeArray.compare(with: fourthNodeArray), true)
        XCTAssertEqual(thirdNodeArray.compare(with: fourthNodeArray), fourthNodeArray.compare(with: thirdNodeArray))
    }
    
    func testRouterNodeAddToContainer() {
        let routeNodeFirst = RouteNode(routeNodeLink: "/", routeNodeID: "testID", routeNodeGetType: standartGetType, routeNodeType: .root)
        let routeNodeSecond = RouteNode(routeNodeLink: "/", routeNodeID: "testID", routeNodeGetType: standartGetType, routeNodeType: .root)
        let routeNodeThird = RouteNode(routeNodeLink: "/some", routeNodeID: "testID", routeNodeGetType: standartGetType, routeNodeType: .root)
        routeNodeFirst.addNodesToContainer(routeNodes: [routeNodeSecond, routeNodeFirst])
        XCTAssertEqual(routeNodeFirst.containerForNodes.compare(with: [routeNodeSecond, routeNodeThird]), true)
        let result = routeNodeFirst.containerForNodes.compare(with: [routeNodeSecond])
        print("ROUTE NODE FIRST CONTAINER FOR NODES COUNT \(routeNodeFirst.containerForNodes.count)")
        print("RESULT \(result)")
        XCTAssertEqual(routeNodeFirst.containerForNodes.compare(with: [routeNodeSecond]), false)
    }
    
    func testRouterNodeAddEdges() {
        let defaultTransitionType = RouteTransitionEdgeType(transitionAnimation: TransitionAnimation.no, transitionData: TransitionData.no)
        let routeNodeFirst = RouteNode(routeNodeLink: "/", routeNodeID: "testID", routeNodeGetType: standartGetType, routeNodeType: .root)
        let routeNodeSecond = RouteNode(routeNodeLink: "/", routeNodeID: "testID", routeNodeGetType: standartGetType, routeNodeType: .root)
        let routeNodeThird = RouteNode(routeNodeLink: "/some", routeNodeID: "testID", routeNodeGetType: standartGetType, routeNodeType: .root)
        routeNodeFirst.addEdge(to: routeNodeSecond, transitionType: defaultTransitionType)
        routeNodeFirst.addEdge(to: routeNodeThird, transitionType: defaultTransitionType)
        let firstEdge = RouteTransitionEdge(firstNode: routeNodeFirst, secondNode: routeNodeSecond, transitionType: defaultTransitionType)
        let secondEdge = RouteTransitionEdge(firstNode: routeNodeFirst, secondNode: routeNodeThird, transitionType: defaultTransitionType)
        let edges = routeNodeFirst.adjacentEdges
        XCTAssertEqual(edges.compare(with: [firstEdge, secondEdge]), [firstEdge,secondEdge].compare(with: edges))
        XCTAssertEqual(edges.compare(with: [firstEdge, secondEdge]), true)
        XCTAssertEqual(edges.compare(with: [firstEdge]), false)
    }
    
    func testRouterTypeGetComparable() {
        XCTAssertEqual(RouteNodeGetType.storyboard("test") == RouteNodeGetType.storyboard("test"), true)
        XCTAssertEqual(RouteNodeGetType.storyboard("test") != RouteNodeGetType.storyboard("second"), true)
        XCTAssertEqual(RouteNodeGetType.xib(1) == RouteNodeGetType.xib(1), true)
        XCTAssertEqual(RouteNodeGetType.xib(1) == RouteNodeGetType.xib(2), false)
        XCTAssertEqual(RouteNodeGetType.storyboard("test") == RouteNodeGetType.xib(1), false)
    }
}
