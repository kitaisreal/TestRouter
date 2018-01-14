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
enum RouteNodeGetType {
    case storyboard(String)
    case xib(Int)
}
class RouteNode {
    
    var isRoot:Bool {
        get {
            return self.routerNodeTypes.isNodeType(of: RouterNodeType.root)
        }
    }
    
    let routeNodeLink:String
    
    let routeNodeGetType:RouteNodeGetType
    
    let routeNodeID:String
    
    let routeNodeType:RouterNodeType
    
    let routerNodeTypes:[RouterNodeType] = []
    
    var containerForNodes:[RouteNode] = []
    
    var adjacentEdges:[RouteTransitionEdge] = []
    
    init(routeNodeLink:String, routeNodeID:String,routeNodeGetType:RouteNodeGetType, routeNodeType:RouterNodeType) {
        self.routeNodeType = routeNodeType
        self.routeNodeLink = routeNodeLink
        self.routeNodeID = routeNodeID
        self.routeNodeGetType = routeNodeGetType
    }
    
    func addEdge(to node:RouteNode, transitionType:RouteTransitionEdgeType) {
        let edge = RouteTransitionEdge(firstNode: self, secondNode: node, transitionType: transitionType)
        self.adjacentEdges.append(edge)
    }
    
    func addNodeToContainer(routeNode:RouteNode) {
            self.containerForNodes.append(routeNode)
    }
    
    func addNodesToContainer(routeNodes:[RouteNode]) {
        for node in routeNodes {
            self.addNodeToContainer(routeNode: node)
        }
    }
    
}

fileprivate extension Array where Element == RouterNodeType {
    func isNodeType(of testNodeType:RouterNodeType) -> Bool{
        for nodeType in self {
            if (nodeType == testNodeType) {
                return true
            }
        }
        return false
    }
}
