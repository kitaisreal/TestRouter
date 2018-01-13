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
        print("OBSERVER GET LINKS \(routerObserverLinks) FOR LINK \(link)")
        for matchedLink in matcher.checkLinks(in: routerObserverLinks, with: link) {
            print("OBSERVER MAKE ACTION \(matchedLink)")
            routerObserverHandler.makeAction(link: matchedLink)
        }
    }
    //FIX THIS SHIT
    
    func setConfig(routerModules:[RouterModule]) {
        self.routerModules = routerModules
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
        let realLink = matcherResponse.link
        print("OBSERVER REAL LINK \(realLink)")
        checkLinkForActions(link: realLink)
        let path = routerModule.getPathToNode(to: realLink)
        print("ANIMATION ROUTE BUG TO LINK \(realLink) \(path.pathType) \(path.path.count) \(path.rootNode.routeNodeLink)")
        print("NAVIGATE PATH COUNT \(path.path) \(path.pathType)")
        Presenter.instance.presentRoutePath(routerPath: path, data: data)
    }
    
    //ROOT LINK
    func presentModule(with link:String) {
        presentModule(with: link, data: nil)
    }
    func presentModule(with link:String, data:Any?) {
        guard let matcherResponse = matcher.getModuleWithLink(with: link, from: routerModules) else {
            return
        }
        //FOR ALL MODULES IN PRESENTED MODULE
        let routerModule = matcherResponse.routerModule
        if (routerModule.routerModuleRootNode.routeNodeLink == presentedModule?.routerModuleRootNode.routeNodeLink) {
            return
        } else {
            self.presentedModule = routerModule
            Presenter.instance.presentRouteModule(routerModule: routerModule, with: data)
        }
    }
    func configureModule(with link:String) {
        guard let matcherResponse = matcher.getModuleWithLink(with: link, from: routerModules) else {
            return
        }
        let routerModule = matcherResponse.routerModule
        Presenter.instance.configureRouteModule(routerModule: routerModule)
    }
    func removeModule(with link:String) {
        guard let matcherResponse = matcher.getModuleWithLink(with: link, from: routerModules) else {
            return
        }
        let routerModule = matcherResponse.routerModule
        Presenter.instance.removeModule(routerModule: routerModule)
    }
    //BACK IN MODULE TEST
    
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
