//
//  PresenterModuleRepository.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/11/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation
import UIKit

class PresenterModuleRepository {
    private var modulesArray:[String:[String:NavigationProtocol]] = [:]
    private var currentPresentedRouterNavigation:[String:NavigationProtocol] = [:]
    private var presenter:ViewPresenterProtocol
    
    init(presenter:ViewPresenterProtocol) {
        self.presenter = presenter
    }
    func setCurrentPresentedModule(routerModule:RouterModule) {
        print("SET CURRENT PRESENTED MODULE STEP 1")
        guard let moduleNavigation = modulesArray[routerModule.routerModuleRootNode.routeNodeLink] else {
            return
        }
        print("SET CURRENT PRESENTED MODULE STEP 2")
        currentPresentedRouterNavigation = moduleNavigation
    }
    func addModule(routerModule:RouterModule) {
        print("ADD MODULE ENTRY POINT")
        guard modulesArray[routerModule.routerModuleRootNode.routeNodeLink] == nil else {
            return
        }
        print("ADD MODULE \(routerModule.routerModuleRootNode.routeNodeLink)")
        var moduleHash:[String:NavigationProtocol] = [:]
        let routerModuleLink = routerModule.routerModuleRootNode.routeNodeLink
        print("ADD MODULE ROUTER MODULE LINK \(routerModuleLink)")
        let routerModulesRootNodes = routerModule.getModuleRootNodes()
        print("ADD MODULE ROUTER MODULES ROOT NODES \(routerModulesRootNodes.count)")
        for rootNode in routerModulesRootNodes {
            guard let navigationRoot = presenter.getView(routeNode: rootNode) as? NavigationProtocol else {
                //SHOULD FAIL?
                continue
            }
            print("ADD MODULE MODULE HASH UPDATE VALUE \(navigationRoot)")
            moduleHash.updateValue(navigationRoot, forKey: rootNode.routeNodeLink)
        }
        print("")
        modulesArray.updateValue(moduleHash, forKey: routerModuleLink)
    }
    func removeModule(rootNodeLink:String) {
        modulesArray.removeValue(forKey: rootNodeLink)
    }
    
    func getModuleNavigation(rootNode:RouteNode) -> [String:NavigationProtocol]?{
        return modulesArray[rootNode.routeNodeLink]
    }
    
    func getModuleNavigationFromPresented(rootNode:RouteNode) -> NavigationProtocol? {
        print("GET MODULE NAVIGATION ENTRY POINT")
        print("GET MODULE NAVIGATION \(rootNode.routeNodeLink) \(rootNode.routeNodeID)")
        let moduleNavigation = self.currentPresentedRouterNavigation[rootNode.routeNodeLink]
        print("GET MODULE NAVIGATION MODULE NAVIGATION \(rootNode.routeNodeLink) \(moduleNavigation)")
        return moduleNavigation
    }
}
