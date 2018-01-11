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

class RouteTransitionEdge {
    let firstNode:RouteNode
    let secondNode:RouteNode
    let transitionType:RouteTransitionEdgeType
    let weight:Int = 1
    
    init(firstNode:RouteNode, secondNode:RouteNode, transitionType:RouteTransitionEdgeType) {
        self.firstNode = firstNode
        self.secondNode = secondNode
        self.transitionType = transitionType
    }
}
