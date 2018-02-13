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
    case container
    case presenter
    case root
    case subModule
}
enum RouteNodeGetType:Equatable {
    static func ==(lhs: RouteNodeGetType, rhs: RouteNodeGetType) -> Bool {
        switch (lhs,rhs) {
        case (let .storyboard(firstValue), let .storyboard(secondValue)):
            return firstValue == secondValue
        case (let .xib(firstValue), let .xib(secondValue)):
            return firstValue == secondValue
        default:
            return false
        }
    }
    
    case storyboard(String)
    case xib(Int)
}
class RouteNode {
    
    var isRoot:Bool {
        get {
            return self.routerNodeTypes.contains(RouterNodeType.root)
        }
    }
    var isData:Bool {
        get {
            return self.routerNodeTypes.contains(RouterNodeType.data)
        }
    }
    var isNavigation:Bool {
        get {
            return self.routerNodeTypes.contains(RouterNodeType.navigation)
        }
    }
    var isContainer:Bool {
        get {
            return self.routerNodeTypes.contains(RouterNodeType.container)
        }
    }
    var isPresenter:Bool {
        get {
            return self.routerNodeTypes.contains(RouterNodeType.presenter)
        }
    }
    var isSubmodule:Bool {
        get {
            return self.routerNodeTypes.contains(RouterNodeType.container)
        }
    }
    let routeNodeLink:String
    
    let routeNodeGetType:RouteNodeGetType
    
    let routeNodeID:String
    
    let routerNodeTypes:[RouterNodeType]
    
    var containerForNodes:[RouteNode] = []
    
    var adjacentEdges:[RouteTransitionEdge] = []
    
    init(routeNodeLink:String, routeNodeID:String,routeNodeGetType:RouteNodeGetType, routeNodeTypes:[RouterNodeType]) {
        //HANDLE A LOT OF ROUTER NODE TYPES
        self.routerNodeTypes = routeNodeTypes
        self.routeNodeLink = routeNodeLink
        self.routeNodeID = routeNodeID
        self.routeNodeGetType = routeNodeGetType
    }
    
    func addEdge(to node:RouteNode, transitionType:RouteTransitionEdgeType) {
        guard node != self else {
            return
        }
        let edge = RouteTransitionEdge(firstNode: self, secondNode: node, transitionType: transitionType)
        self.adjacentEdges.append(edge)
    }
    
    func addNodeToContainer(routeNode:RouteNode) {
        guard routeNode != self else {
            return
        }
        self.containerForNodes.append(routeNode)
    }
    
    func addNodesToContainer(routeNodes:[RouteNode]) {
        for node in routeNodes {
            self.addNodeToContainer(routeNode: node)
        }
    }
    
}
//REWRITE WHEN NODE WILL HAVE TYPES ARRAY
extension RouteNode:Equatable {
    static func ==(lhs: RouteNode, rhs: RouteNode) -> Bool {
        return (lhs.routeNodeID == rhs.routeNodeID && lhs.routeNodeLink == rhs.routeNodeLink && lhs.routerNodeTypes.compare(with: rhs.routerNodeTypes))
    }

}

