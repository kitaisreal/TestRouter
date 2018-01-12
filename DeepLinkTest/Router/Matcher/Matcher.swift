//
//  Matcher.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/4/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation

enum LinkValue {
    case leftMatch(String)
    case rightMatch(String)
    case anyMatch(String)
    case identityMatch(String)
}
class Matcher {
    
    func getModuleWithLink(with link:String,from routerModules:[RouterModule]) -> MatcherResponse? {
        print("GET MODULE WITH LINK ENTRY POINT \(link)")
        let linkValue = getLinkValue(with: link)
        let allRouterModules:[RouterModule] = routerModules.getAllRouterModules()
        
        for routerModule in allRouterModules {
            print("GET MODULE WITH LINK ROUTER MODULE \(routerModule.routerModuleRootNode.routeNodeLink)")
            for linkTest in routerModule.getModuleLinks() {
                if matchLink(in: linkTest, with: linkValue) {
                    let matcherResponse = MatcherResponse(routerModule: routerModule, link: linkTest)
                    print("GET MODULE WITH LINK MATCHER RESPONSE \(matcherResponse.link) \(matcherResponse.routerModule.routerModuleRootNode.routeNodeLink)")
                    return matcherResponse
                }
            }
        }
        return nil
    }
    
    func getLinkValue(with link:String) -> LinkValue{
        var link = link
        if (link.first == "*" && link.last == "*") {
            link.removeFirst()
            link.removeLast()
            return LinkValue.anyMatch(link)
        }
        if (link.first == "*") {
            link.removeFirst()
            return LinkValue.leftMatch(link)
        }
        if (link.last == "*") {
            link.removeLast()
            return LinkValue.rightMatch(link)
        }
        return LinkValue.identityMatch(link)
    }
    
    func checkLinks(in links:[String], with realLink:String) -> [String]{
        var linksMatched:[String] = []
        for link in links {
            let linkValue = self.getLinkValue(with: link)
            let matchLinkResult = matchLink(in: realLink, with: linkValue)
            print("OBSERVER LINK VALUE \(linkValue) REAL LINK \(realLink)")
            if (matchLinkResult) {
                linksMatched.append(link)
            }
        }
        print("OBSERVER MATCH LINKS \(linksMatched)")
        return linksMatched
    }
    
    func matchLink(in firstLink:String, with linkValue:LinkValue) -> Bool {
        
        switch linkValue {
            
        case .leftMatch(let linkValue):
            return leftMatch(firstLink, linkValue)
        case .rightMatch(let linkValue):
            return rightMatch(firstLink, linkValue)
        case .anyMatch(let linkValue):
            return anyMatch(firstLink, linkValue)
        case .identityMatch(let linkValue):
            return identityMatch(firstLink, linkValue)
        }
    }
    
    private func leftMatch(_ first:String, _ second:String) -> Bool {
        let range = first.range(of: second)
        let rightIndex = range?.upperBound.encodedOffset
        return range != nil && rightIndex == first.count
    }
    
    private func rightMatch(_ first:String, _ second:String) -> Bool{
        let range = first.range(of: second)
        let leftIndex = range?.lowerBound.encodedOffset
        return range != nil && leftIndex == 0
    }
    
    private func anyMatch(_ first:String, _ second:String) -> Bool{
        return first.range(of: second) != nil
    }
    
    private func identityMatch(_ first:String, _ second:String) -> Bool  {
        return first == second
    }
    
}

extension Array where Element == RouterModule {
    func getAllRouterModules() -> [RouterModule] {
        var allRouterModules:[RouterModule] = []
        
        for module in self {
            for childModule in module.getModuleModules() {
                allRouterModules.append(childModule)
            }
        }
        return allRouterModules
    }
}





