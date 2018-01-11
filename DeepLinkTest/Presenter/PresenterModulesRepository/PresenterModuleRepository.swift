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
    private var presenter:ViewPresenterProtocol
    
    init(presenter:ViewPresenterProtocol) {
        self.presenter = presenter
    }
    
    func addModule(routerModule:RouterModule) {
        var moduleHash:[String:NavigationProtocol] = [:]
        let routerModuleLink = routerModule.routerModuleRootNode.routeNodeLink
        let routerModulesRootNodes = routerModule.getModuleRootNodes()
        for rootNode in routerModulesRootNodes {
            guard let navigationRoot = presenter.getView(routeNode: rootNode) as? NavigationProtocol else {
                //SHOULD FAIL?
                continue
            }
            moduleHash.updateValue(navigationRoot, forKey: rootNode.routeNodeLink)
        }
        modulesArray.updateValue(moduleHash, forKey: routerModuleLink)
    }
    func removeModule(rootNodeLink:String) {
        modulesArray.removeValue(forKey: rootNodeLink)
    }
    
    func getModuleNavigation(rootNode:RouteNode) -> [String:NavigationProtocol]?{
        return modulesArray[rootNode.routeNodeLink]
    }
}
