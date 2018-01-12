//
//  DeepLinkHandler.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/10/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation

class DeepLinkHandlerResult {
    
    let link:String
    
    let data:Any?
    
    init(link:String, data:Any?) {
        self.link = link
        self.data = data
    }
    
}
class DeepLinkHandler {
    
    func handleDeepLink(link:String) ->  DeepLinkHandlerResult? {
        guard let url = URL(string:link) else {
            return nil
        }
        let components = URLComponents(string: url.absoluteString)
        let data = (components?.queryItems)?[0].value
        let deepLinkHandlerResult = DeepLinkHandlerResult(link: link, data: data)
        return deepLinkHandlerResult
    }
    
}
