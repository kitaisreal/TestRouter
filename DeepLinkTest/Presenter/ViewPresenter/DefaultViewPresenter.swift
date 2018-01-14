//
//  StoryboardViewPresenter.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/9/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation
import UIKit

class DefaultViewPresenter: ViewPresenterProtocol {
    
    func getView(routeNode: RouteNode) -> UIViewController {
        switch routeNode.routeNodeGetType {
        case .storyboard(let value):
            return self.fromStoryboard(with: routeNode.routeNodeID, from: value)
        case .xib(let value):
            //ADD THEN
            return fromXib(with: "test")
        }
    }
    
    private func fromStoryboard(with id:String, from name:String) -> UIViewController {
        return UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: id)
    }
    
    private func fromXib(with name:String) -> UIViewController {
        return UIViewController(nibName: name, bundle: nil)
    }
}
