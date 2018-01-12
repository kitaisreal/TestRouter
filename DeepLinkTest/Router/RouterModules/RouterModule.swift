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
    
    init(configGraph:RouteGraph, routerModuleRootNode:RouteNode) {
        self.configGraph = configGraph
        self.routerModuleRootNode = routerModuleRootNode
        self.currentNodeLink = self.routerModuleRootNode.routeNodeLink
    }
    //TEST THIS SHIT
    func getModuleLinks() -> [String] {
        var moduleLinks:[String] = []
        for link in configGraph.getLinks() {
            moduleLinks.append(link)
        }
        return moduleLinks
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
    func getModuleAllLinks() -> [String] {
        var routeRootLinks:[String] = []
        for module in self.getModuleModules() {
            routeRootLinks.append(module.routerModuleRootNode.routeNodeLink)
        }
        return routeRootLinks
    }
    func getModuleRootNodes() -> [RouteNode]{
        var moduleRootNodes:[RouteNode] = []
        for module in self.getModuleModules() {
            moduleRootNodes.append(module.routerModuleRootNode)
        }
        return moduleRootNodes
    }
    
    func addChildRouterModule(routerModule:RouterModule) {
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
                                               pathType: RouterPathType.push)
        if (fromRootToLinkPath.count >= fromRootToCurrentLinkPath.count) {
            routerPath = RouterPath(rootNode: routerModuleRootNode, path: path, pathType: RouterPathType.push)
        }
        if (fromRootToLinkPath.count < fromRootToCurrentLinkPath.count) {
            let removeCount = fromRootToCurrentLinkPath.count - fromRootToLinkPath.count
            routerPath = RouterPath(rootNode: routerModuleRootNode, path: path,
                                    pathType: RouterPathType.remove(removeCount))
        }
        if (fromRootToCurrentLinkPath.count == fromRootToCurrentLinkPath.count && link == currentNodeLink) {
            routerPath = RouterPath(rootNode: routerModuleRootNode, path: path, pathType: RouterPathType.currentLink)
        }
        currentNodeLink = link
        return routerPath
    }
    
}
