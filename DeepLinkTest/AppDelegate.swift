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
            MainRouter.instance.navigateToLink(link: url.host!, data: data)
        }
        return true
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        CHECK THIS SHIT
//        //**
//        let routeGraph = RouteGraph()
//        let rootNode = RouteNode(routeNodeLink: "/", routeNodeID: "rootVC", routeNodeType: RouteNodeType.navigation)
//        let mainNode = RouteNode(routeNodeLink: "/main", routeNodeID: "main", routeNodeType: RouteNodeType.presenter)
//        let mainFirstChildNode = RouteNode(routeNodeLink: "/main/firstChild", routeNodeID: "firstVC", routeNodeType: RouteNodeType.data)
//        let mainSecondChildNode = RouteNode(routeNodeLink: "/main/secondChild", routeNodeID: "secondVC", routeNodeType: RouteNodeType.presenter)
//        let transitionType = RouteTransitionEdgeType(transitionAnimation: TransitionAnimation.yes, transitionData: TransitionData.no)
//        rootNode.addEdge(to: mainNode, transitionType: transitionType)
//        mainNode.addEdge(to: mainFirstChildNode, transitionType: transitionType)
//        mainNode.addEdge(to: mainSecondChildNode, transitionType: transitionType)
//        routeGraph.addNode(node: rootNode)
//        routeGraph.addNode(node: mainNode)
//        routeGraph.addNode(node: mainFirstChildNode)
//        routeGraph.addNode(node: mainSecondChildNode)
//        Router.instance.setConfig(configGraph: routeGraph)
//        Router.instance.navigate(to: "/")
//        Router.instance.navigate(to: "/main")
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let viewController = storyboard.instantiateViewController(withIdentifier: "rootVC")
//        let anotherViewController = storyboard.instantiateViewController(withIdentifier: "rootVC")
//        print("CHECK IDENTITY FIRST VIEW CONTROLLER \(viewController)")
//        print("ANOTHER VIEW CONTROLLER \(anotherViewController)")
//        let splitViewController = UISplitViewController()
//        let firstNavigationVC = UINavigationController()
//        let secondNavigationVC = UINavigationController()
//        let firstViewController = ViewController()
//        firstViewController.view.backgroundColor = UIColor.blue
//        firstNavigationVC.pushViewController(firstViewController, animated: false)
//        let secondViewController = ViewController()
//        secondViewController.view.backgroundColor = UIColor.green
//        secondNavigationVC.pushViewController(secondViewController, animated: false)
//        splitViewController.viewControllers = [firstNavigationVC, secondNavigationVC]
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window!.rootViewController = UIViewController()
//        window!.makeKeyAndVisible()
//        window!.rootViewController?.present(splitViewController, animated: false)
        
//        window = UIWindow(frame: UIScreen.main.bounds)
//        let transitionType = RouteTransitionEdgeType(transitionAnimation: TransitionAnimation.yes, transitionData: TransitionData.no)
//        let rootNode = RouteNode(routeNodeLink: "RootNode", routeNodeID: "testID", routeNodeType: RouteNodeType.rootContainer)
//        let rootFirstModuleNode = RouteNode(routeNodeLink: "/", routeNodeID: "rootVC", routeNodeType: RouteNodeType.root)
//        rootNode.addNodeToContainer(routeNode: rootFirstModuleNode)
//        let firstModuleNodeRootChild = RouteNode(routeNodeLink: "/main", routeNodeID: "main", routeNodeType: RouteNodeType.presenter)
//        rootNode.addEdge(to: firstModuleNodeRootChild, transitionType: transitionType)
//        let firstModuleGraph = RouteGraph()
//        firstModuleGraph.addNode(node: rootFirstModuleNode)
//        firstModuleGraph.addNode(node: firstModuleNodeRootChild)
//        let firstRouterModule = RouterModule(configGraph: firstModuleGraph, routerModuleRootNode: rootFirstModuleNode)
//        Presenter.instance.setWindow(window: window!)
//        MainRouter.instance.setConfig(rootNode: rootNode, routerModules: [firstRouterModule])
//        MainRouter.instance.navigateToLink(to: "/main")
        //Split view test
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let transitiontype = RouteTransitionEdgeType(transitionAnimation: TransitionAnimation.yes, transitionData: TransitionData.no)
        switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                //REGISTATION ROUTE MODULE
                let rootRegModuleNode = RouteNode(routeNodeLink: "/registration", routeNodeID: "regRootVC", routeNodeType: RouteNodeType.root)
                let regFirstStepNode = RouteNode(routeNodeLink: "/registrationFirstStep", routeNodeID: "regFirstStepVC", routeNodeType: RouteNodeType.presenter)
                let regSecondStepNode = RouteNode(routeNodeLink: "/registrationSecondStep", routeNodeID: "regSecondStepVC", routeNodeType: RouteNodeType.presenter)
                let regThirdStepNode = RouteNode(routeNodeLink: "/registrationThirdStep", routeNodeID: "regThirdStepVC", routeNodeType: RouteNodeType.presenter)
                rootRegModuleNode.addEdge(to: regFirstStepNode, transitionType: transitiontype)
                regFirstStepNode.addEdge(to: regSecondStepNode, transitionType: transitiontype)
                regSecondStepNode.addEdge(to: regThirdStepNode, transitionType: transitiontype)
                let regModuleGraph = RouteGraph()
                regModuleGraph.addNode(node: rootRegModuleNode)
                regModuleGraph.addNode(node: regFirstStepNode)
                regModuleGraph.addNode(node: regSecondStepNode)
                regModuleGraph.addNode(node: regThirdStepNode)
                let regRouterModule = RouterModule(configGraph: regModuleGraph, routerModuleRootNode: rootRegModuleNode)
                
                //SWITCH ROUTE MODULE
                let switchModuleNode = RouteNode(routeNodeLink: "/switch", routeNodeID: "AuthRegSwitchVC", routeNodeType: RouteNodeType.root)
                let switchModuleGraph = RouteGraph()
                switchModuleGraph.addNode(node: switchModuleNode)
                let switchRouterModule = RouterModule(configGraph: switchModuleGraph, routerModuleRootNode: switchModuleNode)
                //AUTHORIZATION ROUTE MODULE
                let authModuleNode = RouteNode(routeNodeLink: "/authorization", routeNodeID: "authorizationRootVC", routeNodeType: RouteNodeType.root)
                let authModuleGraph = RouteGraph()
                authModuleGraph.addNode(node: authModuleNode)
                let authRouterModule = RouterModule(configGraph: authModuleGraph, routerModuleRootNode: authModuleNode)
                //MAIN ROUTE MODULE
                let rootFirstModuleNode = RouteNode(routeNodeLink: "/firstModule", routeNodeID: "navigationTVVC", routeNodeType: RouteNodeType.root)
                let dataVC = RouteNode(routeNodeLink: "/firstModule/data", routeNodeID: "dataVC", routeNodeType: RouteNodeType.presenter)
                rootFirstModuleNode.addEdge(to: dataVC, transitionType: transitiontype)
                let detailVC = RouteNode(routeNodeLink: "/firstModule/data/detail", routeNodeID: "detailVC", routeNodeType: RouteNodeType.data)
                dataVC.addEdge(to: detailVC, transitionType: transitiontype)
                let firstModuleGraph = RouteGraph()
                firstModuleGraph.addNode(node: rootFirstModuleNode)
                firstModuleGraph.addNode(node: dataVC)
                firstModuleGraph.addNode(node: detailVC)
                let mainRouterModule = RouterModule(configGraph: firstModuleGraph, routerModuleRootNode: rootFirstModuleNode)
                //
                Presenter.instance.setWindow(window: window!)
                MainRouter.instance.setConfig(presentedModule: mainRouterModule, routerModules: [regRouterModule, switchRouterModule, authRouterModule, mainRouterModule])
                MainRouter.instance.navigateToLink(to: "/firstModule/data")
            case .pad:
                let rootNode = RouteNode(routeNodeLink: "RootNode", routeNodeID: "rootSplitVC", routeNodeType: RouteNodeType.rootContainer)
                let rootFirstModuleNode = RouteNode(routeNodeLink: "/firstModule", routeNodeID: "navigationTVVC", routeNodeType: RouteNodeType.root)
                let rootSecondModuleNode = RouteNode(routeNodeLink: "/secondModule", routeNodeID: "navigationDetailVC", routeNodeType: RouteNodeType.root)
                let firstModuleChildNode = RouteNode(routeNodeLink: "/firstModule/data", routeNodeID: "dataVC", routeNodeType: RouteNodeType.presenter)
                let secondModuleChildNode = RouteNode(routeNodeLink: "/secondModule/detail", routeNodeID: "detailVC", routeNodeType: RouteNodeType.data)
                rootNode.addNodeToContainer(routeNode: rootFirstModuleNode)
                rootNode.addNodeToContainer(routeNode: rootSecondModuleNode)
                rootFirstModuleNode.addEdge(to: firstModuleChildNode, transitionType: transitiontype)
                rootSecondModuleNode.addEdge(to: secondModuleChildNode, transitionType: transitiontype)
                let firstModuleGraph = RouteGraph()
                firstModuleGraph.addNode(node: rootFirstModuleNode)
                firstModuleGraph.addNode(node: firstModuleChildNode)
                let secondModuleGraph = RouteGraph()
                secondModuleGraph.addNode(node: rootSecondModuleNode)
                secondModuleGraph.addNode(node: secondModuleChildNode)
                let firstRouterModule = RouterModule(configGraph: firstModuleGraph, routerModuleRootNode: rootFirstModuleNode)
                let secondRouterModule = RouterModule(configGraph: secondModuleGraph, routerModuleRootNode: rootSecondModuleNode)
                Presenter.instance.setWindow(window: window!)
                let mainRouterModule = RouterModule(configGraph: RouteGraph(), routerModuleRootNode: rootNode)
                mainRouterModule.addChildsRouterModules(routerModule: [firstRouterModule, secondRouterModule])
                MainRouter.instance.setConfig(presentedModule: mainRouterModule , routerModules: [mainRouterModule])
                MainRouter.instance.navigateToLink(to: "/firstModule/data")
                MainRouter.instance.navigateToLink(to: "/secondModule/detail")
            case .unspecified:
                fatalError()
            case .tv:
                fatalError()
            case .carPlay:
                fatalError()
        }
//        let testViewController = UIViewController()
//        testViewController.view.backgroundColor = UIColor.green
//        let anotherViewController = UIViewController()
//        anotherViewController.view.backgroundColor = UIColor.brown
//        window!.rootViewController = testViewController
//        window!.makeKeyAndVisible()
//        testViewController.modalTransitionStyle  = .coverVertical
//        testViewController.modalPresentationStyle = .custom
//        testViewController.present(anotherViewController, animated: false)
//        anotherViewController.dismiss(animated: false)
//        let transitiontype = RouteTransitionEdgeType(transitionAnimation: TransitionAnimation.yes, transitionData: TransitionData.no)
//        let rootNode = RouteNode(routeNodeLink: "RootNode", routeNodeID: "rootVC", routeNodeType: RouteNodeType.rootContainer)
//        let rootFirstModuleNode = RouteNode(routeNodeLink: "/firstModule", routeNodeID: "navigationTVVC", routeNodeType: RouteNodeType.root)
//        rootNode.addNodeToContainer(routeNode: rootFirstModuleNode)
//        let firstDetailVC = RouteNode(routeNodeLink: "/firstModule/firstDetailVC", routeNodeID: "firstDetailVC", routeNodeType: RouteNodeType.presenter)
//        rootFirstModuleNode.addEdge(to: firstDetailVC, transitionType: transitiontype)
//        let secondDetailVC = RouteNode(routeNodeLink: "/firstModule/secondDetailVC", routeNodeID: "secondDetailVC", routeNodeType: RouteNodeType.data)
//        firstDetailVC.addEdge(to: secondDetailVC, transitionType: transitiontype)
//        let firstModuleGraph = RouteGraph()
//        firstModuleGraph.addNode(node: rootFirstModuleNode)
//        firstModuleGraph.addNode(node: firstDetailVC)
//        firstModuleGraph.addNode(node: secondDetailVC)
//        let firstRouterModule = RouterModule(configGraph: firstModuleGraph, routerModuleRootNode: rootFirstModuleNode)
//        Presenter.instance.setWindow(window: window!)
//        MainRouter.instance.setConfig(rootNode: rootNode, routerModules: [firstRouterModule])
//        MainRouter.instance.navigateToLink(to: "/firstModule/firstDetailVC")
//
//        let testNavigationController = UINavigationController()
//        let testFirstController = UIViewController()
//        testFirstController.view.backgroundColor = UIColor.green
//        let testSecondController = UIViewController()
//        testSecondController.view.backgroundColor = UIColor.brown
//        window!.rootViewController = testNavigationController
//        window!.makeKeyAndVisible()
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        let splitVC = storyBoard.instantiateViewController(withIdentifier: "rootSplitVC") as! UISplitViewController
//        let firstNavController = UINavigationController()
//        let secondNavController = UINavigationController()
//        let firstUIController = UIViewController()
//        firstUIController.view.backgroundColor = UIColor.blue
//        let secondUIController = UIViewController()
//        secondUIController.view.backgroundColor = UIColor.green
//        window!.rootViewController = splitVC
//        window!.makeKeyAndVisible()
//
//        splitVC.viewControllers = [firstNavController, secondNavController]
//        firstNavController.pushViewController(firstUIController, animated: false)
//        secondNavController.pushViewController(secondUIController, animated: false)
        //Split view test
//        window = UIWindow(frame:UIScreen.main.bounds)
//
//        let rootViewController = UISplitViewController()
//
//        let navigationController = UINavigationController()
//        let secondNavigationController = UINavigationController()
//        let anotherViewController = UIViewController()
//        anotherViewController.view.backgroundColor = UIColor.blue
//        let mainViewController = UIViewController()
//        mainViewController.view.backgroundColor = UIColor.green
//
//        rootViewController.viewControllers = [navigationController, secondNavigationController]
//        window!.rootViewController = rootViewController
//        window!.makeKeyAndVisible()
//
//        secondNavigationController.pushViewController(anotherViewController, animated: false)
//        navigationController.pushViewController(mainViewController, animated: false)
////
//        window = UIWindow(frame: UIScreen.main.bounds)
//        let viewController = UIViewController()
//        viewController.view.backgroundColor = UIColor.white
//        let navigationController = UINavigationController()
//
//        viewController.present(navigationController, animated: false)
//        window!.rootViewController = viewController
//        window!.makeKeyAndVisible()
//        let mainViewController = UIViewController()
//        mainViewController.view.backgroundColor = UIColor.green
//        navigationController.pushViewController(mainViewController, animated: false)
////        viewController.present(navigationController, animated: false)
//        let anotherVC = UIViewController()
//        anotherVC.view.backgroundColor = UIColor.blue
//        navigationController.pushViewController(anotherVC, animated: false)
        
        
        //NEW TESTS
        
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

