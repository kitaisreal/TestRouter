//
//  RouterObserverHandler.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/12/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation

fileprivate class ObserverAction {
    
    let id:String
    
    let action:RouterObserverHandler.Action
    
    
    init(id:String, action:@escaping RouterObserverHandler.Action) {
        self.id = id
        self.action = action
    }
    
}

fileprivate extension Array where Element == ObserverAction {
    
    mutating func removeObserverAction(by id:String) {
        for (index, action) in self.enumerated() {
            if (action.id == id) {
                self.remove(at: index)
            }
        }
    }
}
enum RouterObserverLinkType {
    case moduleConfiguration
    case moduleRemove
    case moduleNavigation
    case modulePresent
    case deepLinkHandle
    case custom
}

class RouterObserverHandler {
    
    typealias Action = () -> ()
    
    private var mainActionMap:[RouterObserverLinkType:[String:[ObserverAction]]] = [:]
    
    init() {
        mainActionMap.updateValue([:], forKey: RouterObserverLinkType.modulePresent)
    }
    
    func addObserver(link:String, id:String, linkType:RouterObserverLinkType, action:@escaping Action) {
        if mainActionMap[linkType] == nil {
            mainActionMap.updateValue([:], forKey: linkType)
        }
        if mainActionMap[linkType]?[link] == nil {
            mainActionMap[linkType]?.updateValue([], forKey: link)
        }
        let observerAction = ObserverAction(id: id, action: action)
        mainActionMap[linkType]?[link]?.append(observerAction)
    }
    
    func makeAction(with link:String, by linkType:RouterObserverLinkType) {
        if let observerActions = mainActionMap[linkType]?[link] {
            for observerAction in observerActions {
                observerAction.action()
            }
        }
    }
    
    func removeObserver(linkType:RouterObserverLinkType,link:String, id:String) {
        mainActionMap[linkType]?[link]?.removeObserverAction(by: id)
    }
    
    func removeObservers(linkType:RouterObserverLinkType ,link:String) {
        mainActionMap[linkType]?[link]?.removeAll()
    }
    
    func removeObservers(by linkType:RouterObserverLinkType) {
        mainActionMap[linkType]?.removeAll()
    }
    func removeAllObservers() {
        mainActionMap.removeAll()
    }
    func getAllLinks(by linktype:RouterObserverLinkType) -> [String]{
        if let links = mainActionMap[linktype] {
            return links.keys.map() {return $0}
        }
        return []
    }
}
