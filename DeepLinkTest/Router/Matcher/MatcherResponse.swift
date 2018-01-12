//
//  MatcherResponse.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/9/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation

class MatcherResponse {
    
    let routerModule:RouterModule
    
    let link:String
    
    init(routerModule:RouterModule, link:String) {
        self.routerModule = routerModule
        self.link = link
    }
    
}
