//
//  MainRouter.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/8/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation

class MainRouter {
    
    private var routerModules:[RouterModule] = []
    
    private var presentedModule:RouterModule?
    
    private let routerObserverHandler:RouterObserverHandler = RouterObserverHandler()
    
    private let matcher:Matcher = Matcher()
    
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
        let routerModule = matcherResponse.routerModule
        let realLink = matcherResponse.link
        checkLinkForActions(link: realLink)
        print("REGISTRATION BUG NAVIGATE TO LINK \(link) ROUTER MODULE \(routerModule.routerModuleRootNode)")
        let path = routerModule.getPathToNode(to: realLink)
        print("REGISTRATION BUG PATH COUNT \(path.path.count) \(path.rootNode.routeNodeLink)")
        Presenter.instance.presentRoutePath(routerPath: path, data: data)
    }
    func getBackInModule(with link:String, data:Any?) {
        guard let matcherResponse = matcher.getModuleWithLink(with: link, from: routerModules) else {
            return
        }
        let routerModule = matcherResponse.routerModule
        let realLink = matcherResponse.link
        checkLinkForActions(link: realLink)
        routerModule.getBackInModule()
    }
    func presentModule(with link:String) {
        presentModule(with: link, data: nil)
    }
    
    func presentModule(with link:String, data:Any?) {
        guard let matcherResponse = matcher.getModuleWithLink(with: link, from: routerModules) else {
            return
        }
        let realLink = matcherResponse.link
        checkLinkForActions(link: realLink)
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
    
}
