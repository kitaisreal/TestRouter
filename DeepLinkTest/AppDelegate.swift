//
//  AppDelegate.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/4/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if let host = url.host {
            let components = URLComponents(string: url.absoluteString)
            let data = (components?.queryItems)?[0].value
            MainRouter.instance.navigate(to: url.host!, data: data)
        }
        return true
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        let transitiontype = RouteTransitionEdgeType(transitionAnimation: TransitionAnimation.yes, transitionData: TransitionData.no)
        switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                //REGISTATION ROUTE MODULE
                let rootRegModuleNode = RouteNode(routeNodeLink: "/registration", routeNodeID: "regRootVC", routeNodeType: RouterNodeType.root)
                let regFirstStepNode = RouteNode(routeNodeLink: "/registrationFirstStep", routeNodeID: "regFirstStepVC", routeNodeType: RouterNodeType.presenter)
                let regSecondStepNode = RouteNode(routeNodeLink: "/registrationSecondStep", routeNodeID: "regSecondStepVC", routeNodeType: RouterNodeType.presenter)
                let regThirdStepNode = RouteNode(routeNodeLink: "/registrationThirdStep", routeNodeID: "regThirdStepVC", routeNodeType: RouterNodeType.presenter)
                rootRegModuleNode.addEdge(to: regFirstStepNode, transitionType: transitiontype)
                regFirstStepNode.addEdge(to: regSecondStepNode, transitionType: transitiontype)
                regSecondStepNode.addEdge(to: regThirdStepNode, transitionType: transitiontype)
                let regRouterModule = RouterModule(nodes: [rootRegModuleNode, regFirstStepNode, regSecondStepNode, regThirdStepNode], routerModuleRootNode: rootRegModuleNode)
                
                //SWITCH ROUTE MODULE
                let switchModuleNode = RouteNode(routeNodeLink: "/switch", routeNodeID: "AuthRegSwitchVC", routeNodeType: RouterNodeType.root)
                let switchRouterModule = RouterModule(nodes: [switchModuleNode], routerModuleRootNode: switchModuleNode)
                //AUTHORIZATION ROUTE MODULE
                let authModuleNode = RouteNode(routeNodeLink: "/authorization", routeNodeID: "authorizationRootVC", routeNodeType: RouterNodeType.root)
                let authRouterModule = RouterModule(nodes: [authModuleNode], routerModuleRootNode: authModuleNode)
                //MAIN ROUTE MODULE
                let rootFirstModuleNode = RouteNode(routeNodeLink: "/firstModule", routeNodeID: "navigationTVVC", routeNodeType: RouterNodeType.root)
                let dataVC = RouteNode(routeNodeLink: "/firstModule/data", routeNodeID: "dataVC", routeNodeType: RouterNodeType.presenter)
                rootFirstModuleNode.addEdge(to: dataVC, transitionType: transitiontype)
                let detailVC = RouteNode(routeNodeLink: "/firstModule/data/detail", routeNodeID: "detailVC", routeNodeType: RouterNodeType.data)
                dataVC.addEdge(to: detailVC, transitionType: transitiontype)
                let mainRouterModule = RouterModule(nodes: [rootFirstModuleNode, dataVC, detailVC], routerModuleRootNode: rootFirstModuleNode)
                //TEST ROUTE MODULE
//                let testModuleNode = RouteNode(routeNodeLink: "/", routeNodeID: "testModuleRootVC", routeNodeType: RouterNodeType.root)
                let testModuleSecondNode = RouteNode(routeNodeLink: "/test", routeNodeID: "testModuleVC", routeNodeType: RouterNodeType.root)
//                testModuleNode.addEdge(to: testModuleSecondNode, transitionType: transitiontype)
                let testRouterModule = RouterModule(nodes: [testModuleSecondNode], routerModuleRootNode: testModuleSecondNode)
                //
                Presenter.instance.setWindow(window: window!)
                MainRouter.instance.setConfig(presentedModule: testRouterModule, routerModules: [regRouterModule, switchRouterModule, authRouterModule, mainRouterModule,testRouterModule])
                MainRouter.instance.navigate(to: "/test")
            case .pad:
                let rootNode = RouteNode(routeNodeLink: "RootNode", routeNodeID: "rootSplitVC", routeNodeType: RouterNodeType.rootContainer)
                let rootFirstModuleNode = RouteNode(routeNodeLink: "/firstModule", routeNodeID: "navigationTVVC", routeNodeType: RouterNodeType.root)
                let rootSecondModuleNode = RouteNode(routeNodeLink: "/secondModule", routeNodeID: "navigationDetailVC", routeNodeType: RouterNodeType.root)
                let firstModuleChildNode = RouteNode(routeNodeLink: "/firstModule/data", routeNodeID: "dataVC", routeNodeType: RouterNodeType.presenter)
                let secondModuleChildNode = RouteNode(routeNodeLink: "/secondModule/detail", routeNodeID: "detailVC", routeNodeType: RouterNodeType.data)
                rootNode.addNodeToContainer(routeNode: rootFirstModuleNode)
                rootNode.addNodeToContainer(routeNode: rootSecondModuleNode)
                rootFirstModuleNode.addEdge(to: firstModuleChildNode, transitionType: transitiontype)
                rootSecondModuleNode.addEdge(to: secondModuleChildNode, transitionType: transitiontype)
                let firstRouterModule = RouterModule(nodes: [rootFirstModuleNode, firstModuleChildNode], routerModuleRootNode: rootFirstModuleNode)
                let secondRouterModule = RouterModule(nodes: [rootSecondModuleNode, secondModuleChildNode], routerModuleRootNode: rootSecondModuleNode)
                Presenter.instance.setWindow(window: window!)
                let mainRouterModule = RouterModule(nodes:[rootNode], routerModuleRootNode: rootNode)
                mainRouterModule.addChildsRouterModules(routerModule: [firstRouterModule, secondRouterModule])
                MainRouter.instance.setConfig(presentedModule: mainRouterModule , routerModules: [mainRouterModule])
                MainRouter.instance.navigate(to: "/firstModule/data")
                MainRouter.instance.navigate(to: "/secondModule/detail")
            case .unspecified:
                fatalError()
            case .tv:
                fatalError()
            case .carPlay:
                fatalError()
        }
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

