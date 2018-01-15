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
                let rootRegModuleNode = RouteNode(routeNodeLink: "/registration", routeNodeID: "regRootVC", routeNodeGetType: RouteNodeGetType.storyboard("Registration"), routeNodeType: RouterNodeType.root)
                let regFirstStepNode = RouteNode(routeNodeLink: "/registrationFirstStep", routeNodeID: "regFirstStepVC",routeNodeGetType: RouteNodeGetType.storyboard("Registration"), routeNodeType: RouterNodeType.presenter)
                let regSecondStepNode = RouteNode(routeNodeLink: "/registrationSecondStep", routeNodeID: "regSecondStepVC",routeNodeGetType: RouteNodeGetType.storyboard("Registration"), routeNodeType: RouterNodeType.presenter)
                let regThirdStepNode = RouteNode(routeNodeLink: "/registrationThirdStep", routeNodeID: "regThirdStepVC",routeNodeGetType: RouteNodeGetType.storyboard("Registration"), routeNodeType: RouterNodeType.presenter)
                rootRegModuleNode.addEdge(to: regFirstStepNode, transitionType: transitiontype)
                regFirstStepNode.addEdge(to: regSecondStepNode, transitionType: transitiontype)
                regSecondStepNode.addEdge(to: regThirdStepNode, transitionType: transitiontype)
                let regRouterModule = RouterModule(nodes: [rootRegModuleNode, regFirstStepNode, regSecondStepNode, regThirdStepNode], routerModuleRootNode: rootRegModuleNode)
                
                //SWITCH ROUTE MODULE
                let switchModuleNode = RouteNode(routeNodeLink: "/switch", routeNodeID: "AuthRegSwitchVC",routeNodeGetType: RouteNodeGetType.storyboard("Switch"), routeNodeType: RouterNodeType.root)
                let switchRouterModule = RouterModule(nodes: [switchModuleNode], routerModuleRootNode: switchModuleNode)
                //AUTHORIZATION ROUTE MODULE
                let authModuleNode = RouteNode(routeNodeLink: "/authorization", routeNodeID: "authorizationRootVC", routeNodeGetType: RouteNodeGetType.storyboard("Authorization"),routeNodeType: RouterNodeType.root)
                let authRouterModule = RouterModule(nodes: [authModuleNode], routerModuleRootNode: authModuleNode)
                //MAIN ROUTE MODULE
                let rootFirstModuleNode = RouteNode(routeNodeLink: "/firstModule", routeNodeID: "navigationTVVC",routeNodeGetType: RouteNodeGetType.storyboard("Main"), routeNodeType: RouterNodeType.root)
                let dataVC = RouteNode(routeNodeLink: "/firstModule/data", routeNodeID: "dataVC",routeNodeGetType: RouteNodeGetType.storyboard("Main"), routeNodeType: RouterNodeType.presenter)
                rootFirstModuleNode.addEdge(to: dataVC, transitionType: transitiontype)
                let detailVC = RouteNode(routeNodeLink: "/firstModule/data/detail", routeNodeID: "detailVC",routeNodeGetType: RouteNodeGetType.storyboard("Main"), routeNodeType: RouterNodeType.data)
                dataVC.addEdge(to: detailVC, transitionType: transitiontype)
                let mainRouterModule = RouterModule(nodes: [rootFirstModuleNode, dataVC, detailVC], routerModuleRootNode: rootFirstModuleNode)
                //TEST ROUTE MODULE
//                let testModuleNode = RouteNode(routeNodeLink: "/", routeNodeID: "testModuleRootVC", routeNodeType: RouterNodeType.root)
                let testModuleSecondNode = RouteNode(routeNodeLink: "/test", routeNodeID: "testModuleVC", routeNodeGetType: RouteNodeGetType.storyboard("Main"), routeNodeType: RouterNodeType.root)
//                testModuleNode.addEdge(to: testModuleSecondNode, transitionType: transitiontype)
                let testRouterModule = RouterModule(nodes: [testModuleSecondNode], routerModuleRootNode: testModuleSecondNode)
                //TEST TAB BAR MODULE
                let tabBarModuleRootNode = RouteNode(routeNodeLink: "/", routeNodeID: "tabBarRootVC", routeNodeGetType: RouteNodeGetType.storyboard("TabBarModuleTest"), routeNodeType: RouterNodeType.root)
                let firstNVC = RouteNode(routeNodeLink: "/first", routeNodeID: "firstRootNVC", routeNodeGetType: RouteNodeGetType.storyboard("TabBarModuleTest"), routeNodeType: RouterNodeType.root)
                let secondNVC = RouteNode(routeNodeLink: "/second", routeNodeID: "secondRootNVC", routeNodeGetType: RouteNodeGetType.storyboard("TabBarModuleTest"), routeNodeType: RouterNodeType.root)
                let firstVC = RouteNode(routeNodeLink: "/firstVC", routeNodeID: "firstTabVC", routeNodeGetType: RouteNodeGetType.storyboard("TabBarModuleTest"), routeNodeType: RouterNodeType.presenter)
                let secondVC = RouteNode(routeNodeLink: "/secondVC", routeNodeID: "secondTabVC", routeNodeGetType: RouteNodeGetType.storyboard("TabBarModuleTest"), routeNodeType: RouterNodeType.presenter)
                tabBarModuleRootNode.addNodesToContainer(routeNodes: [firstNVC, secondNVC])
                print("TAB BAR MODULE ")
                firstNVC.addEdge(to: firstVC, transitionType: transitiontype)
                secondNVC.addEdge(to: secondVC, transitionType: transitiontype)
                let rootRouterModule = RouterModule(nodes: [tabBarModuleRootNode], routerModuleRootNode: tabBarModuleRootNode)
                let firstRouterModule = RouterModule(nodes: [firstNVC,firstVC], routerModuleRootNode: firstNVC)
                let secondRouterModule = RouterModule(nodes: [secondNVC,secondVC], routerModuleRootNode: secondNVC)
                rootRouterModule.addChildsRouterModules(routerModule: [firstRouterModule,secondRouterModule])
                //TEST PAGE MODULE
                let testPageModuleRootNode = RouteNode(routeNodeLink: "/pageRoot", routeNodeID: "pageRootVC", routeNodeGetType: RouteNodeGetType.storyboard("PageVCModuleTest"), routeNodeType: RouterNodeType.root)
                let firstPageRootNode = RouteNode(routeNodeLink: "/firstPage", routeNodeID: "firstPageVC", routeNodeGetType: RouteNodeGetType.storyboard("PageVCModuleTest"), routeNodeType: RouterNodeType.root)
                let firstPageRouterModule = RouterModule(nodes: [firstPageRootNode], routerModuleRootNode: firstPageRootNode)
                let secondPageRootNode = RouteNode(routeNodeLink: "/secondPage", routeNodeID: "secondPageVC", routeNodeGetType: RouteNodeGetType.storyboard("PageVCModuleTest"), routeNodeType: RouterNodeType.root)
                let secondPageRouterModule = RouterModule(nodes: [secondPageRootNode], routerModuleRootNode: secondPageRootNode)
                let thirdPageRootNode = RouteNode(routeNodeLink: "/thirdPage", routeNodeID: "thirdPageVC", routeNodeGetType: RouteNodeGetType.storyboard("PageVCModuleTest"), routeNodeType: RouterNodeType.root)
                let thirdPageRouterModule = RouterModule(nodes: [thirdPageRootNode], routerModuleRootNode: thirdPageRootNode)
                testPageModuleRootNode.addNodesToContainer(routeNodes: [firstPageRootNode, secondPageRootNode, thirdPageRootNode])
                let testPageRouterModule = RouterModule(nodes: [testPageModuleRootNode, firstPageRootNode, secondPageRootNode, thirdPageRootNode], routerModuleRootNode: testPageModuleRootNode)
                testPageRouterModule.addChildsRouterModules(routerModule: [firstPageRouterModule, secondPageRouterModule, thirdPageRouterModule])
                //
                MainRouter.instance.addObserver(link: "*/*", id: "AppDelegateObserver") {
                    print("OBSERVER ACTION BUG ANY LINK SHOULD MATCH")
                }
                Presenter.instance.setWindow(window: window!)
                MainRouter.instance.setConfig(routerModules: [regRouterModule, switchRouterModule, authRouterModule, mainRouterModule,testRouterModule , rootRouterModule, testPageRouterModule])
                print("CONFIGURE MODULE WITH \(rootRouterModule.routerModuleRootNode.routeNodeLink)")
                MainRouter.instance.configureModule(with: "/registration")
                MainRouter.instance.navigate(to: "/registrationFirstStep")
                MainRouter.instance.presentModule(with: "/registration")
//                MainRouter.instance.configureModule(with: rootRouterModule.routerModuleRootNode.routeNodeLink)
//                MainRouter.instance.navigate(to: "/firstVC")
//                MainRouter.instance.navigate(to: "/secondVC")
//                MainRouter.instance.presentModule(with: "/")
//                MainRouter.instance.configureModule(with: mainRouterModule.routerModuleRootNode.routeNodeLink)
//                MainRouter.instance.navigate(to: "/firstModule/data")
//                MainRouter.instance.presentModule(with: "/firstModule")
            case .pad:
                let rootNode = RouteNode(routeNodeLink: "RootNode", routeNodeID: "rootSplitVC",routeNodeGetType: RouteNodeGetType.storyboard("Main"), routeNodeType: RouterNodeType.rootContainer)
                let rootFirstModuleNode = RouteNode(routeNodeLink: "/firstModule", routeNodeID: "navigationTVVC", routeNodeGetType: RouteNodeGetType.storyboard("Main"),routeNodeType: RouterNodeType.root)
                let rootSecondModuleNode = RouteNode(routeNodeLink: "/secondModule", routeNodeID: "navigationDetailVC",routeNodeGetType: RouteNodeGetType.storyboard("Main"), routeNodeType: RouterNodeType.root)
                let firstModuleChildNode = RouteNode(routeNodeLink: "/firstModule/data", routeNodeID: "dataVC", routeNodeGetType: RouteNodeGetType.storyboard("Main"),routeNodeType: RouterNodeType.presenter)
                let secondModuleChildNode = RouteNode(routeNodeLink: "/secondModule/detail", routeNodeID: "detailVC",routeNodeGetType: RouteNodeGetType.storyboard("Main"), routeNodeType: RouterNodeType.data)
                rootNode.addNodeToContainer(routeNode: rootFirstModuleNode)
                rootNode.addNodeToContainer(routeNode: rootSecondModuleNode)
                rootFirstModuleNode.addEdge(to: firstModuleChildNode, transitionType: transitiontype)
                rootSecondModuleNode.addEdge(to: secondModuleChildNode, transitionType: transitiontype)
                let firstRouterModule = RouterModule(nodes: [rootFirstModuleNode, firstModuleChildNode], routerModuleRootNode: rootFirstModuleNode)
                let secondRouterModule = RouterModule(nodes: [rootSecondModuleNode, secondModuleChildNode], routerModuleRootNode: rootSecondModuleNode)
                Presenter.instance.setWindow(window: window!)
                let mainRouterModule = RouterModule(nodes:[rootNode], routerModuleRootNode: rootNode)
                mainRouterModule.addChildsRouterModules(routerModule: [firstRouterModule, secondRouterModule])
                MainRouter.instance.setConfig( routerModules: [mainRouterModule])
                MainRouter.instance.navigate(to: "/firstModule/data")
                MainRouter.instance.navigate(to: "/secondModule/detail")
            case .unspecified:
                fatalError()
            case .tv:
                fatalError()
            case .carPlay:
                fatalError()
        }
        let array:[TestTypeEnum] = []
        
        return true
    }
    func testArray(array:[TestTypeEnum], testType:TestTypeEnum) {
        for i in array {
            if (i == testType) {
                

            }
        }
    }
    enum TestTypeEnum {
        case first
        case second
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

