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
    private var modulesArray:[String:[String:RootProtocol]] = [:]
    private var currentPresentedRouterNavigation:[String:RootProtocol] = [:]
    private var presenter:ViewPresenterProtocol
    
    init(presenter:ViewPresenterProtocol) {
        self.presenter = presenter
    }
    
    func setCurrentPresentedModule(routerModule:RouterModule) {
        guard let moduleNavigation = modulesArray[routerModule.routerModuleRootNode.routeNodeLink] else {
            return
        }
        currentPresentedRouterNavigation = moduleNavigation
    }
    
    func addModule(routerModule:RouterModule) {
        guard modulesArray[routerModule.routerModuleRootNode.routeNodeLink] == nil else {
            return
        }
        var moduleHash:[String:RootProtocol] = [:]
        let routerModuleLink = routerModule.routerModuleRootNode.routeNodeLink
        let routerModulesRootNodes = routerModule.getModuleRootNodes()
        for rootNode in routerModulesRootNodes {
            guard let navigationRoot = presenter.getView(routeNode: rootNode) as? RootProtocol else {
                continue
            }
            moduleHash.updateValue(navigationRoot, forKey: rootNode.routeNodeLink)
        }
        modulesArray.updateValue(moduleHash, forKey: routerModuleLink)
    }
    
    func removeModule(rootNodeLink:String) {
        modulesArray.removeValue(forKey: rootNodeLink)
    }
    
    func getModuleRootFromPresented(rootNode:RouteNode) -> RootProtocol? {
        let moduleNavigation = self.currentPresentedRouterNavigation[rootNode.routeNodeLink]
        return moduleNavigation
    }
}
