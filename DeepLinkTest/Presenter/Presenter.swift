//
//  Presenter.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/5/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation
import UIKit

class Presenter {

    static let instance = Presenter()
    
    private let presenterModuleRepository:PresenterModuleRepository
    
    private var rootViewController:UIViewController = UIViewController() {
        didSet {
            guard let window = window else {
                return
            }
            window.rootViewController = rootViewController
            window.makeKeyAndVisible()
        }
    }
    
    private var window:UIWindow?
    private var viewPresenter:ViewPresenterProtocol
    
    private init() {
        viewPresenter =  DefaultViewPresenter()
        presenterModuleRepository = PresenterModuleRepository(presenter: viewPresenter)
    }
    
    func setWindow(window:UIWindow) {
        self.window = window
    }
    
    func removeModule(routerModule:RouterModule) {
        //IF CONTAINER BE IN WINDOW ROOT SO ???
        presenterModuleRepository.removeModule(routerModule: routerModule)
    }
    
    func presentRouteModule(routerModule:RouterModule, with data:Any?) {
        let root = self.presenterModuleRepository.getModuleRoot(rootNode: routerModule.routerModuleRootNode)
        print("ROUTER MODULE TO PRESENT \(routerModule.routerModuleRootNode.routeNodeLink) with \(root)")
        guard let rootVC = root as? UIViewController else {
            fatalError("Router module not configured before present")
        }
        (rootVC as? DataTransferProtocol)?.setData(data: data)
        self.rootViewController = rootVC
    }
    
    func configureRouteModule(routerModule:RouterModule) {
        print("PRESENTER CONFIGURE ROUTE MODULE \(routerModule.routerModuleRootNode.routeNodeLink)")
        self.presenterModuleRepository.addModule(routerModule: routerModule)
        self.configureContainerNode(rootContainerNode: routerModule.routerModuleRootNode)
    }
    
    private func configureContainerNode(rootContainerNode:RouteNode) {
        //KOSTIL REWRITE
        print("CONFIGURE CONTAINER NODE \(rootContainerNode.containerForNodes.count) \(rootContainerNode.routeNodeLink)")
        guard rootContainerNode.containerForNodes.count != 0 else {
            return
        }
        var routerModulesRootsForContainer:[RootProtocol] = []
        
        for node in rootContainerNode.containerForNodes {
            if (node.isRoot) {
                if let rootVC = presenterModuleRepository.getModuleRoot(rootNode: node) {
                    routerModulesRootsForContainer.append(rootVC)
                }
            } else {
                continue
            }
        }
        print()
        let rootView = presenterModuleRepository.getModuleRoot(rootNode: rootContainerNode)
        print("ROUTER MODULES ROOTS FOR CONTAINERS \(routerModulesRootsForContainer.count)")
        (rootView as? ContainerProtocol)?.contain(modules: routerModulesRootsForContainer)
    }
    
    func presentRoutePath(routerPath:RouterPath, data:Any?) {
        let routerModuleRootVC = presenterModuleRepository.getModuleRoot(rootNode: routerPath.rootNode)
        
        guard let routerModuleNavigationVC = routerModuleRootVC as? NavigationProtocol else {
            return
        }
        print("PRESENT ROUTE PATH \(routerPath.pathType) \(routerPath.rootNode.routeNodeLink) \(routerPath.path.count)")
        let path = routerPath.path
        switch routerPath.pathType {
        case .push:
            self.presentPushRoutePath(navigationVC: routerModuleNavigationVC, path: path, data: data)
        case .remove(let value):
            self.presentRemoveRoutePath(navigationVC: routerModuleNavigationVC, path: path, data: data, count: value)
        case .currentLink:
            self.presentCurrentLinkRoutePath(navigationVC: routerModuleNavigationVC, path: path, data: data)
        case .empty:
            break
        }
        
    }
    private func presentCurrentLinkRoutePath (navigationVC:NavigationProtocol, path:[RouteNode],data:Any?) {
        (navigationVC.getTopModule() as? DataTransferProtocol)?.setData(data: data)
    }
    
    private func presentRemoveRoutePath(navigationVC:NavigationProtocol, path:[RouteNode],data:Any?, count:Int) {
        //REWRITE FOR
        var currentCount = count
        print("REMOVE BUG CURRENT COUNT \(currentCount)")
        while (currentCount != 0) {
            print("REMOVE BUG POP VIEW CONTROLLER")
            navigationVC.removeFromTop()
            currentCount -= 1
        }
        (navigationVC.getTopModule() as? DataTransferProtocol)?.setData(data: data)
    }
    
    private func presentPushRoutePath(navigationVC:NavigationProtocol, path:[RouteNode], data:Any?) {
        //REWRITE
        for routeNode in path {
            if (routeNode.isNavigation) {
                fatalError()
                break
            }
            if (routeNode.isData) {
                let viewVC = viewPresenter.getView(routeNode: routeNode) as! PresenterProtocol
                navigationVC.push(module: viewVC)
            }
            if (routeNode.isRoot) {
                fatalError()
                break
            }
            if (routeNode.isContainer) {
                break
            }
            if (routeNode.isPresenter) {
                let viewVC = viewPresenter.getView(routeNode: routeNode) as! PresenterProtocol
                navigationVC.push(module: viewVC)
            }
            if (routeNode.isSubmodule) {
                break
            }
        }
        (navigationVC.getTopModule() as? DataTransferProtocol)?.setData(data: data)
    }
}
