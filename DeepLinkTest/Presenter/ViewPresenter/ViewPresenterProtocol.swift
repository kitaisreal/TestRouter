//
//  ViewPresenterProtocol.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/9/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation
import UIKit

protocol ViewPresenterProtocol {
    
    func getView(routeNode:RouteNode) -> UIViewController
    
}
