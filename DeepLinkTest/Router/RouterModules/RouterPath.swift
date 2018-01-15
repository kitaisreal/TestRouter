//
//  RouterPath.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/8/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation

enum RouterPathType:Equatable {
    static func ==(lhs: RouterPathType, rhs: RouterPathType) -> Bool {
        switch (lhs,rhs) {
        case (.push, .push):
            return true
        case (let .remove(value1), let .remove(value2)):
            return value1 == value2
        case (.empty, .empty):
            return true
        case (.currentLink, .currentLink):
            return true
        default:
            return false
        }
    }
    
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
