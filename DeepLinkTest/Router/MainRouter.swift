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
    
    let routerObserverHandler:RouterObserverHandler = RouterObserverHandler()
    
    let matcher:Matcher = Matcher()
    
    static let instance = MainRouter()
    
    private init() {
        
    }
    
    func addObserver(link:String,id:String, action:@escaping RouterObserverHandler.Action) {
        routerObserverHandler.addObserver(link: link, id: id, action: action)
    }
    
    func removeObserver(link:String, id:String) {
        routerObserverHandler.removeObserver(link: link, id: id)
    }
    private func checkLinkForActions(link:String) {
        let routerObserverLinks = routerObserverHandler.getLinks()
        print("OBSERVER GET LINKS \(routerObserverLinks)")
        for matchedLink in matcher.checkLinks(in: routerObserverLinks, with: link) {
            routerObserverHandler.makeAction(link: matchedLink)
        }
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
    
    func navigate(to link:String) {
        navigate(to:link, data: nil)
    }
    
    func navigate(to link:String, data:Any?) {
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
        checkLinkForActions(link: realLink)
        let path = routerModule.getPathToNode(to: realLink)
        Presenter.instance.presentRoutePath(routerPath: path, data: data)
    }
    
    //ROOT LINK
    func navigateToModule(with link:String) {
        guard let matcherResponse = matcher.getModuleWithLink(with: link, from: routerModules) else {
            return
        }
        //FOR ALL MODULES IN PRESENTED MODULE
        let routerModule = matcherResponse.routerModule
        if (routerModule.routerModuleRootNode.routeNodeLink == presentedModule?.routerModuleRootNode.routeNodeLink) {
            return
        } else {
            self.presentedModule = routerModule
            Presenter.instance.presentRouteModule(routerModule: routerModule)
        }
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
        guard let presentedModule = self.presentedModule else {
            return false
        }
        for link in presentedModule.getModuleLinks() {
            if (linkToCheck == link) {
                return true
            }
        }
        return false
    }
    
}
