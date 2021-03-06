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
    
    private var moduleRootsDictionary:[String:RootProtocol] = [:]

    private var presenter:ViewPresenterProtocol
    
    init(presenter:ViewPresenterProtocol) {
        self.presenter = presenter
    }
    
    
    func addModule(routerModule:RouterModule) {

        let moduleRootNodes = routerModule.getModuleRootNodes()
        print("ADD MODULE \(moduleRootNodes.count)")
        for rootNode in moduleRootNodes {
            print("ADD MODULE FIRST STEP")
            guard moduleRootsDictionary[rootNode.routeNodeLink] == nil else {
                continue
            }
            print("ADD  MODULE SECOND STEP")
            guard let rootProtocol = presenter.getView(routeNode: rootNode) as? RootProtocol else {
                continue
            }
            print("ADD MODULE THIRD STEP")
            print("ADD  MODULE \(rootProtocol) for key \(rootNode.routeNodeLink)")
            moduleRootsDictionary.updateValue(rootProtocol, forKey: rootNode.routeNodeLink)
        }
    }
    
    func removeModule(routerModule:RouterModule) {
        let moduleRootNodes = routerModule.getModuleRootNodes()
        for rootNode in moduleRootNodes {
            _ = moduleRootsDictionary.removeValue(forKey: rootNode.routeNodeLink)
        }
    }
    
    func getModuleRoot(rootNode:RouteNode) -> RootProtocol? {
        return moduleRootsDictionary[rootNode.routeNodeLink]
    }
}
