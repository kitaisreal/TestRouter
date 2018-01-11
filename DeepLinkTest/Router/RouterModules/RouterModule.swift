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
    
    func getModuleLinks() -> [String] {
        var moduleLinks:[String] = []
        for link in configGraph.getLinks() {
            moduleLinks.append(link)
        }
        guard childRouterModules.count != 0 else {
            return moduleLinks
        }
        for module in childRouterModules {
            for link in module.getModuleLinks() {
                moduleLinks.append(link)
            }
        }
        return moduleLinks
    }
    func getModuleRootNodes() -> [RouteNode]{
        var moduleRootNodes:[RouteNode] = []
        moduleRootNodes.append(self.routerModuleRootNode)
        guard childRouterModules.count != 0 else {
            return moduleRootNodes
        }
        for module in childRouterModules {
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
        var routerPath:RouterPath = RouterPath(rootNodeLink: routerModuleRootNode.routeNodeLink,
                                               path: [],
                                               pathType: RouterPathType.push)
        if (fromRootToLinkPath.count >= fromRootToCurrentLinkPath.count) {
            routerPath = RouterPath(rootNodeLink: routerModuleRootNode.routeNodeLink, path: path, pathType: RouterPathType.push)
        }
        if (fromRootToLinkPath.count < fromRootToCurrentLinkPath.count) {
            let removeCount = fromRootToCurrentLinkPath.count - fromRootToLinkPath.count
            routerPath = RouterPath(rootNodeLink: routerModuleRootNode.routeNodeLink, path: path,
                                    pathType: RouterPathType.remove(removeCount))
        }
        if (fromRootToCurrentLinkPath.count == fromRootToCurrentLinkPath.count && link == currentNodeLink) {
            routerPath = RouterPath(rootNodeLink: routerModuleRootNode.routeNodeLink, path: path, pathType: RouterPathType.currentLink)
        }
        currentNodeLink = link
        return routerPath
    }
    
}
