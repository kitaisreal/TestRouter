//
//  RouterMatcherModulesTest.swift
//  DeepLinkTestTests
//
//  Created by Maksim Kita on 1/11/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import XCTest
@testable import DeepLinkTest

class RouterMatcherModuleTests:XCTest {
    
    func testSomething() {
        let firstModuleNode = RouteNode(routeNodeLink: "/firstModule", routeNodeID: "secondModuleNodeID", routeNodeType: RouterNodeType.data)
        let graph = RouteGraph()
        graph.addNode(node: firstModuleNode)
        let secondModuleNode = RouteNode(routeNodeLink: "/secondModule", routeNodeID: "secondModuleNodeID", routeNodeType: RouterNodeType.data)
        let anotherGraph = RouteGraph()
        graph.addNode(node: secondModuleNode)
        let firstRouterModule = RouterModule(configGraph: graph, routerModuleRootNode: firstModuleNode)
        let secondRouterModule = RouterModule(configGraph: anotherGraph, routerModuleRootNode: secondModuleNode)
        let containerModuleNode = RouteNode(routeNodeLink: "/", routeNodeID: "containerModuleNode", routeNodeType: RouterNodeType.data)
        let thirdGraph = RouteGraph()
        thirdGraph.addNode(node: containerModuleNode)
        let thirdModule = RouterModule(configGraph: thirdGraph, routerModuleRootNode: containerModuleNode)
        thirdModule.addChildsRouterModules(routerModule: [firstRouterModule,secondRouterModule])
        let matcher = Matcher()
        let response = matcher.getModuleWithLink(with: "/firstModule", from: [thirdModule])
        print(response?.routerModule.routerModuleRootNode.routeNodeLink)
        print(response?.link)
    }
}
