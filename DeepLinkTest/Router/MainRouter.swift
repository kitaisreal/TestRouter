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
    
    func addObserver(link:String,id:String, linkType:RouterObserverLinkType, action:@escaping RouterObserverHandler.Action) {
        routerObserverHandler.addObserver(link: link, id: id, linkType: linkType, action: action)
    }
    
    func removeObserver(linkType:RouterObserverLinkType ,link:String, id:String) {
        routerObserverHandler.removeObserver(linkType: linkType, link: link, id: id)
    }
    
    func removeObservers(linkType:RouterObserverLinkType) {
        
//        routerObserverHandler.removeObservers(linkType: linkType)
    }
    func removeObservers(linkType:RouterObserverLinkType, link:String) {
        routerObserverHandler.removeObservers(linkType: linkType, link: link)
    }
    func removeObservers() {
        routerObserverHandler.removeAllObservers()
    }
    private func checkObserverForActions(link:String, linkType:RouterObserverLinkType) {
        let routerObserverLinks = routerObserverHandler.getAllLinks(by: linkType)
        for matchedLink in matcher.checkRealLinkInLinks(in: routerObserverLinks, with: link) {
            routerObserverHandler.makeAction(with: matchedLink, by: linkType)
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
        checkObserverForActions(link: realLink, linkType: RouterObserverLinkType.moduleNavigation)
        let path = routerModule.getPathToNode(to: realLink)
        Presenter.instance.presentRoutePath(routerPath: path, data: data)
    }
    func getBackInModule(with link:String, data:Any?) {
        guard let matcherResponse = matcher.getModuleWithLink(with: link, from: routerModules) else {
            return
        }
        let routerModule = matcherResponse.routerModule
        let realLink = matcherResponse.link
        routerModule.getBackInModule()
        checkObserverForActions(link: realLink, linkType: RouterObserverLinkType.moduleNavigation)
    }
    func presentModule(with link:String) {
        presentModule(with: link, data: nil)
    }
    
    func presentModule(with link:String, data:Any?) {
        guard let matcherResponse = matcher.getModuleWithLink(with: link, from: routerModules) else {
            return
        }
        let realLink = matcherResponse.link
        checkObserverForActions(link: realLink, linkType: RouterObserverLinkType.modulePresent)
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
        let realLink = matcherResponse.link
        checkObserverForActions(link: realLink, linkType: RouterObserverLinkType.moduleConfiguration)
        Presenter.instance.configureRouteModule(routerModule: routerModule)
    }
    
    func removeModule(with link:String) {
        guard let matcherResponse = matcher.getModuleWithLink(with: link, from: routerModules) else {
            return
        }
        let routerModule = matcherResponse.routerModule
        let realLink = matcherResponse.link
        checkObserverForActions(link: realLink, linkType: RouterObserverLinkType.moduleRemove)
        Presenter.instance.removeModule(routerModule: routerModule)
    }
    
}
