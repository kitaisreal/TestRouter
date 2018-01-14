//
//  TabBarViewController.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/14/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import UIKit

//ASK FOR THIS
class TabBarViewController: UITabBarController,RootProtocol,ContainerProtocol, UITabBarControllerDelegate {
    
    func contain(modules: [PresenterProtocol]) {
        print("TAB BAR CONTAIN MODULE \(modules.count)")
        guard let containModules = modules as? [UIViewController] else {
            return
        }
    }
    override func viewDidLoad() {
        self.delegate = self
    }
    func contain(modules: [NavigationProtocol]) {
        print("TAB BAR CONTAIN MODULE \(modules.count)")
        guard let containModules = modules as? [UIViewController] else{
            return
        }
        
        let tabOne = containModules[0]
        let tabOneBarItem = UITabBarItem(title: "Tab 1", image: nil, selectedImage: nil)
        tabOne.tabBarItem = tabOneBarItem
        let tabTwo = containModules[1]
        let tabTwoBarItem = UITabBarItem(title: "Tab 2", image: nil, selectedImage: nil)
        tabTwo.tabBarItem = tabTwoBarItem
        
        self.viewControllers = [containModules[0], containModules[1]]
        self.selectedIndex = 1000
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        print("Selected \(viewController.title!)")
    }

}
