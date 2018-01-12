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
    private var viewPresenter:ViewPresenterProtocol = StoryboardViewPresenter(storyboardName: "Main")
    
    private init() {
        presenterModuleRepository = PresenterModuleRepository(presenter: viewPresenter)
    }
    
    func setWindow(window:UIWindow) {
        self.window = window
    }
    
    func removeModuleNavigation(routerModule:RouterModule) {
        //IF CONTAINER BE IN WINDOW ROOT SO ???
        presenterModuleRepository.removeModule(rootNodeLink: routerModule.routerModuleRootNode.routeNodeLink)
    }
    
    func presentRouteModule(routerModule:RouterModule) {
        self.presenterModuleRepository.addModule(routerModule: routerModule)
        self.presenterModuleRepository.setCurrentPresentedModule(routerModule: routerModule)
        guard let rootVC = self.presenterModuleRepository.getModuleRootFromPresented(rootNode: routerModule.routerModuleRootNode) as? UIViewController else {
            //Comments throw fix
            fatalError()
        }
        self.configureContainerNode(rootContainerNode: routerModule.routerModuleRootNode)
        self.rootViewController = rootVC
    }
    
    
    private func configureContainerNode(rootContainerNode:RouteNode) {
        //KOSTIL REWRITE
        guard rootContainerNode.containerForNodes.count != 0 else {
            return
        }
        var routerModulesNavigation:[NavigationProtocol] = []
        
        for node in rootContainerNode.containerForNodes {
            if (node.routeNodeType == RouterNodeType.root) {
                guard let rootVC = presenterModuleRepository.getModuleRootFromPresented(rootNode: node) as? NavigationProtocol else {
                    continue
                }
                routerModulesNavigation.append(rootVC)
            } else {
                continue
            }
        }
        print()
        let rootView = presenterModuleRepository.getModuleRootFromPresented(rootNode: rootContainerNode)
        (rootView as? ContainerProtocol)?.contain(modules: routerModulesNavigation)
    }
    
    func presentRoutePath(routerPath:RouterPath, data:Any?) {
        print("NODE PATH BUG ENTRY POINT")
        print("NODE PATH BUG ROOT NODE \(routerPath.rootNode.routeNodeLink)")
        print("NODE PATH BUG PATH COUNT \(routerPath.path.count)")
        for node in routerPath.path {
            print("NODE PATH BUG \(node.routeNodeLink)")
        }
        print("NODE PATH BUG BEFORE GUARD")
        guard let routerModuleNavigationVC = presenterModuleRepository.getModuleRootFromPresented(rootNode: routerPath.rootNode) as? NavigationProtocol else {
            return
        }
        let path = routerPath.path
        print("NODE PATH BUG \(path.count)")
        for node in path {
            print("NODE PATH BUG NODE \(node.routeNodeLink)")
        }
        switch routerPath.pathType {
        case .push:
            self.presentPushRoutePath(navigationVC: routerModuleNavigationVC, path: path, data: data)
        case .remove(let value):
            print("REMOVE BUG PRESENTER LETS PRESENT PATH")
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
        print("PRESENT PUSH ROUTE PATH \(navigationVC) \(path.count) ")
        for routeNode in path {
            switch routeNode.routeNodeType {
            case .navigation:
                break
            case .data:
                let viewVC = viewPresenter.getView(routeNode: routeNode) as! PresenterProtocol
                navigationVC.push(module: viewVC)
            case .rootContainer:
                break
            case .presenter:
                let viewVC = viewPresenter.getView(routeNode: routeNode) as! PresenterProtocol
                print("PRESENT ROUTE PATH PRESENTER VIEW VC \(routeNode.routeNodeLink) VC \(viewVC)")
                navigationVC.push(module: viewVC)
            case .root:
                break
            }
        }
        (navigationVC.getTopModule() as? DataTransferProtocol)?.setData(data: data)
    }
}
