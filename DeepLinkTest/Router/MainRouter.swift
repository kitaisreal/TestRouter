//
//  MainRouter.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/8/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation

class MainRouter {
    
    var routerModules:[RouterModule] = []
    
    let matcher:Matcher = Matcher()
    static let instance = MainRouter()
    
    private init() {
    }
    
    func setRouterModules() {
        
    }
    
    func setConfig(rootNode:RouteNode, routerModules:[RouterModule]) {
        print("MAIN ROUTER SET CONFIG")
        self.routerModules = routerModules
        Presenter.instance.initRouteModules(routeModulesNodes: self.routerModules)
        print("INIT ROUTE MODULES")
        Presenter.instance.initRootRouterNode(rootNode: rootNode)
        print("INIT ROOT ROUTER NODE")
    }
    func navigateToLink(to link:String) {
        navigateToLink(link: link, data: nil)
    }
    
    func navigateToLink(link:String, data:Any?) {
        guard let matcherResponse = matcher.getModuleWithLink(with: link, from: routerModules) else {
            return
        }
        let routerModule = matcherResponse.routerModule
        let realLink = matcherResponse.link
        let path = routerModule.getPathToNode(to: realLink)
        Presenter.instance.presentRoutePath(routerPath: path, data: data)
    }
    func navigateToLink(link:String, data:Any?, sender:RouterSenderProtocol) {
        guard let matcherResponse = matcher.getModuleWithLink(with: link, from: routerModules) else {
            return
        }
        let routerModule = matcherResponse.routerModule
        let realLink = matcherResponse.link
        let path = routerModule.getPathToNode(to: realLink)
        
        Presenter.instance.presentRoutePath(routerPath: path, data: data)
    }
}
