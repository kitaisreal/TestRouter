//
//  RouterModule.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/8/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation

class RouterModule {
    
    private let configGraph:RouteGraph
    
    let routerModuleRootNode:RouteNode
    
    private var childRouterModules:[RouterModule] = []
    
    private var currentNodeLink:String
    
    private var nodeLinksStack:[String] = []
    
    init(nodes:[RouteNode], routerModuleRootNode:RouteNode) {
        let routerGraph = RouteGraph()
        routerGraph.addNodes(nodes: nodes)
        self.configGraph = routerGraph
        self.routerModuleRootNode = routerModuleRootNode
        self.currentNodeLink = self.routerModuleRootNode.routeNodeLink
        nodeLinksStack.append(self.currentNodeLink)
    }
    
    //TEST THIS SHIT
    func getModuleLinks() -> [String] {
        var moduleLinks:[String] = []
        for link in configGraph.getLinks() {
            moduleLinks.append(link)
        }
        return moduleLinks
    }
    
//    func getBackPath() -> RouterPath? {
//        print("GET BACK \(nodeLinksStack.count)")
//        if (nodeLinksStack.count > 1) {
//            _ = nodeLinksStack.popLast()
//        }
//        guard let previousLink = nodeLinksStack.popLast() else {
//            return nil
//        }
//        print("PREVIOUS LINK \(previousLink)")
//        return getPathToNode(to: previousLink)
//    }
    
    func getBackInModule() {
        print("GET BACK \(nodeLinksStack.count)")
        if (nodeLinksStack.count > 1) {
            _ = nodeLinksStack.popLast()
        }
        guard let previousLink = nodeLinksStack.last else {
            return
        }
        currentNodeLink = previousLink
        
    }
    
    func getModuleModules() -> [RouterModule] {
        var routerModules:[RouterModule] = []
        routerModules.append(self)
        guard childRouterModules.count != 0 else {
            return routerModules
        }
        for childModule in childRouterModules {
            for module in childModule.getModuleModules() {
                routerModules.append(module)
            }
        }
        return routerModules
    }
    
    func getModuleAllRootsLinks() -> [String] {
        var routeRootLinks:[String] = []
        for module in self.getModuleModules() {
            routeRootLinks.append(module.routerModuleRootNode.routeNodeLink)
        }
        return routeRootLinks
    }
    
    func getModuleAllLinks() -> [String] {
        var allLinksInModule:[String] = []
        for module in self.getModuleModules() {
            allLinksInModule.append(contentsOf: module.getModuleLinks())
        }
        return allLinksInModule
    }
    
    func getModuleRootNodes() -> [RouteNode]{
        var moduleRootNodes:[RouteNode] = []
        for module in self.getModuleModules() {
            moduleRootNodes.append(module.routerModuleRootNode)
        }
        return moduleRootNodes
    }
    
    func addChildRouterModule(routerModule:RouterModule) {
        guard routerModule != self else {
            return
        }
        self.childRouterModules.append(routerModule)
    }
    
    func addChildsRouterModules(routerModule:[RouterModule]) {
        for module in routerModule {
            self.addChildRouterModule(routerModule: module)
        }
    }
    
    func getPathToNode(to link:String) -> RouterPath {
        let fromRootToLinkPath = configGraph.findPathToNode(from: routerModuleRootNode.routeNodeLink, to: link)
        let fromRootToCurrentLinkPath = configGraph.findPathToNode(from: routerModuleRootNode.routeNodeLink, to: currentNodeLink)
        let path = configGraph.findPathToNode(from: currentNodeLink, to: link)
        var routerPath:RouterPath = RouterPath(rootNode: routerModuleRootNode,
                                               path: [],
                                               pathType: RouterPathType.empty)
        if (fromRootToLinkPath.count > fromRootToCurrentLinkPath.count) {
            routerPath = RouterPath(rootNode: routerModuleRootNode, path: path, pathType: RouterPathType.push)
            currentNodeLink = link
            nodeLinksStack.append(currentNodeLink)
            return routerPath
        }
        if (fromRootToLinkPath.count < fromRootToCurrentLinkPath.count) {
            let removeCount = fromRootToCurrentLinkPath.count - fromRootToLinkPath.count
            routerPath = RouterPath(rootNode: routerModuleRootNode, path: path,
                                    pathType: RouterPathType.remove(removeCount))
            currentNodeLink = link
            nodeLinksStack.append(currentNodeLink)
            return routerPath
        }
        if (fromRootToCurrentLinkPath.count == fromRootToCurrentLinkPath.count && link == currentNodeLink) {
            routerPath = RouterPath(rootNode: routerModuleRootNode, path: path, pathType: RouterPathType.currentLink)
            currentNodeLink = link
            nodeLinksStack.append(currentNodeLink)
            return routerPath
        }
        return routerPath
    }
    
}

extension RouterModule:Equatable {
    static func ==(lhs: RouterModule, rhs: RouterModule) -> Bool {
        return lhs.configGraph == rhs.configGraph && lhs.routerModuleRootNode == rhs.routerModuleRootNode && lhs.childRouterModules.compare(with: rhs.childRouterModules)
    }
}
