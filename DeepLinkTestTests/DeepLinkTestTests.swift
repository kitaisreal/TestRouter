//
//  DeepLinkTestTests.swift
//  DeepLinkTestTests
//
//  Created by Maksim Kita on 1/4/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import XCTest
@testable import DeepLinkTest
import UIKit
class DeepLinkTestTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        let node = Node(value: "MainNode", previousNode: nil)
        let graph = Graph<String>(mainNode: node)
        node.addNode(node: Node(value: "FirstNode", previousNode: node))
        node.addNode(node: Node(value:"SecondNode", previousNode: node))
        let thirdNode = Node(value:"ThirdNode", previousNode:node)
        let thirdNodeChild = Node(value:"ThirdNodeFirstChild", previousNode:thirdNode)
        thirdNode.addNode(node: thirdNodeChild)
        thirdNode.addNode(node: Node(value:"TrirdNodeSecondChild", previousNode:thirdNode))
        node.addNode(node: thirdNode)
        graph.printGraphValues()
        print("PATH TO THIRD NODE")
        thirdNodeChild.pathToNode()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
