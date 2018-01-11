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
    var presentedModule:RouterModule?
    
    let matcher:Matcher = Matcher()
    static let instance = MainRouter()
    
    private init() {
    }
    //FIX THIS SHIT
    func setPresentedModule(moduleToPresent:RouterModule) {
        self.presentedModule = moduleToPresent
    }
    
    func setConfig(presentedModule:RouterModule, routerModules:[RouterModule]) {
        self.routerModules = routerModules
        self.presentedModule = presentedModule
        guard let moduleToPresent = self.presentedModule else {
            return
        }
        Presenter.instance.presentRouteModule(routerModule: moduleToPresent)
    }
    func navigateToLink(to link:String) {
        navigateToLink(link: link, data: nil)
    }
    
    func navigateToLink(link:String, data:Any?) {
        print("NAVIGATE TO LINK BUG ENTRY POINT \(link)")
        guard let matcherResponse = matcher.getModuleWithLink(with: link, from: routerModules) else {
            return
        }
        //REWRITE ONLY LINKS MAYBE
        print("NAVIGATE TO LINK BUG MATCHER RESPONSE \(matcherResponse.link) \(matcherResponse.routerModule.routerModuleRootNode.routeNodeLink)")
        let routerModule = matcherResponse.routerModule
        print("NAVIGATE TO LINK ROUTER MODULE \(routerModule.routerModuleRootNode.routeNodeLink)")
        let linkCheck = checkLink(linkToCheck: routerModule.routerModuleRootNode.routeNodeLink)
        print("NAVIGATE TO LINK LINK CHECK \(linkCheck)")
        if (linkCheck == false) {
            //FIND IN ROUTER MODULES
            self.presentedModule = routerModule
            Presenter.instance.presentRouteModule(routerModule: routerModule)
        }
        let realLink = matcherResponse.link
        let path = routerModule.getPathToNode(to: realLink)
        Presenter.instance.presentRoutePath(routerPath: path, data: data)
    }
    
    func navigateToLink(link:String, data:Any?, sender:RouterSenderProtocol) {
        print("NAVIGATE TO LINK BUG ENTRY POINT \(link)")
        guard let matcherResponse = matcher.getModuleWithLink(with: link, from: routerModules) else {
            return
        }
        //REWRITE ONLY LINKS MAYBE
        print("NAVIGATE TO LINK BUG MATCHER RESPONSE \(matcherResponse.link) \(matcherResponse.routerModule.routerModuleRootNode.routeNodeLink)")
        let routerModule = matcherResponse.routerModule
        print("NAVIGATE TO LINK ROUTER MODULE \(routerModule.routerModuleRootNode.routeNodeLink)")
        let linkCheck = checkLink(linkToCheck: routerModule.routerModuleRootNode.routeNodeLink)
        print("NAVIGATE TO LINK LINK CHECK \(linkCheck)")
        if (linkCheck == false) {
            //FIND IN ROUTER MODULES
            self.presentedModule = routerModule
            Presenter.instance.presentRouteModule(routerModule: routerModule)
        }
        let realLink = matcherResponse.link
        let path = routerModule.getPathToNode(to: realLink)
        Presenter.instance.presentRoutePath(routerPath: path, data: data)
    }
    //REWRITE
    private func checkLink(linkToCheck:String) -> Bool {
        for link in getPresenterModuleLinks() {
            if (linkToCheck == link) {
                return true
            }
        }
        return false
    }
    private func getPresenterModuleLinks() -> [String] {
        guard let presentedModule = self.presentedModule else {
            return []
        }
        var routeRootLinks:[String] = []
        routeRootLinks.append(presentedModule.routerModuleRootNode.routeNodeLink)
        for childModule in presentedModule.getModuleModules() {
            routeRootLinks.append(childModule.routerModuleRootNode.routeNodeLink)
        }
        return routeRootLinks
    }
}
