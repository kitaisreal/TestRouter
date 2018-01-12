//
//  RouteNode.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/5/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation

enum RouterNodeType {
    case navigation
    case data
    case rootContainer
    case presenter
    case root
}
enum RouterNodeGet {
    case storyboard(String)
    case xib
}
class RouteNode {
    
    let routeNodeLink:String
    let routeNodeID:String
    let routeNodeType:RouterNodeType
    //FIX THIS
    var containerForNodes:[RouteNode] = []
    var adjacentEdges:[RouteTransitionEdge] = []
    
    init(routeNodeLink:String, routeNodeID:String, routeNodeType:RouterNodeType) {
        self.routeNodeType = routeNodeType
        self.routeNodeLink = routeNodeLink
        self.routeNodeID = routeNodeID
    }
    
    func addEdge(to node:RouteNode, transitionType:RouteTransitionEdgeType) {
        let edge = RouteTransitionEdge(firstNode: self, secondNode: node, transitionType: transitionType)
        self.adjacentEdges.append(edge)
    }
    func addNodeToContainer(routeNode:RouteNode) {
        if (self.routeNodeType == RouterNodeType.rootContainer) {
            self.containerForNodes.append(routeNode)
        }
    }
    
    
}

