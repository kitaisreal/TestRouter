//
//  RouterPath.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/8/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation

enum RouterPathType {
    case push
    case remove(Int)
    case empty
    case currentLink
}

class RouterPath {
    
    let path:[RouteNode]
    let rootNode:RouteNode
    let pathType:RouterPathType
    
    init(rootNode:RouteNode,path:[RouteNode], pathType:RouterPathType) {
        self.path = path
        self.rootNode = rootNode
        self.pathType = pathType
    }
}
