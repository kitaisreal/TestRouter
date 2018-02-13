//
//  RouteTransitionEdge.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/5/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation

enum TransitionAnimation {
    case yes
    case no
}
enum TransitionData {
    case yes
    case no
}

struct RouteTransitionEdgeType {
    
    let transitionAnimation:TransitionAnimation
    let transitionData:TransitionData
    init(transitionAnimation:TransitionAnimation, transitionData:TransitionData) {
        self.transitionAnimation = transitionAnimation
        self.transitionData = transitionData
    }
}
extension RouteTransitionEdgeType:Equatable {
    
    static func ==(lhs: RouteTransitionEdgeType, rhs: RouteTransitionEdgeType) -> Bool {
        return (lhs.transitionAnimation == rhs.transitionAnimation && lhs.transitionData == rhs.transitionData)
    }
    
    
}
class RouteTransitionEdge {
    let firstNode:RouteNode
    let secondNode:RouteNode
    let transitionType:RouteTransitionEdgeType
    
    init(firstNode:RouteNode, secondNode:RouteNode, transitionType:RouteTransitionEdgeType) {
        self.firstNode = firstNode
        self.secondNode = secondNode
        self.transitionType = transitionType
    }
}
extension RouteTransitionEdge:Equatable {
    static func ==(lhs: RouteTransitionEdge, rhs: RouteTransitionEdge) -> Bool {
        return (lhs.firstNode == rhs.firstNode && lhs.secondNode == rhs.secondNode && lhs.transitionType == rhs.transitionType)
    }
}

