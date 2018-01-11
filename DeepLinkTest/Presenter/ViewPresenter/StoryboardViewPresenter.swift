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
    
}
