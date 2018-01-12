//
//  StoryboardViewPresenter.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/9/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation
import UIKit

class StoryboardViewPresenter: ViewPresenterProtocol {
    
    private let storyboard:UIStoryboard
    
    init(storyboardName:String) {
        self.storyboard = UIStoryboard(name: storyboardName, bundle: nil)
    }
    
    func getView(routeNode: RouteNode) -> UIViewController {
        return self.storyboard.instantiateViewController(withIdentifier: routeNode.routeNodeID)
    }
    
    private func fromStoryboard(with id:String, from name:String) -> UIViewController {
        return UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: id)
    }
    
    private func fromXib(with name:String) -> UIViewController {
        return UIViewController(nibName: name, bundle: nil)
    }
}
