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
    case custom
}
//TESTS FOR THIS
//OBSERVERS ON MODULE PRESENT: MODULE REMOVE: NAVIGATE TO LINK: NAVIGATE TO CUSTOM LINK: MODULE CONFIGURE
//ADD LINKS FOR CONFIGURE MODULE PRESENT MODULE NAVIGATE TO LINK
class RouterObserverHandler {
    
    typealias Action = () -> ()
    
    private var actionMap:[String:[ObserverAction]] = [:]
    
    private var mainActionMap:[RouterObserverLinkType:[String:[ObserverAction]]] = [:]
    
    init() {
        mainActionMap.updateValue([:], forKey: RouterObserverLinkType.modulePresent)
    }
    
    func addObserver(link:String,id:String,action:@escaping Action) {
        print("OBSERVER ADD OBSERVER \(link) \(id)")
        let observerAction = ObserverAction(id: id, action: action)
        guard actionMap[link] != nil else {
            let actionArray:[ObserverAction] = [observerAction]
            actionMap.updateValue(actionArray, forKey: link)
            return
        }
        actionMap[link]?.append(observerAction)
    }
    
    func removeObserver(link:String, id:String) {
        actionMap[link]?.removeObserverAction(by: id)
    }
    
    func makeAction(link:String) {
        guard let linkActionArray = actionMap[link] else {
            return
        }
        print("OBSERVER LINK ACTION ARRAY COUNT \(linkActionArray.count)")
        for i in linkActionArray {
            print("OBSERVER LINK ACTION \(i.id)")
        }
        for observerAction in linkActionArray {
            let action = observerAction.action
            action()
        }
    }
    
    func getLinks() -> [String] {
        var keys:[String] = []
        for key in actionMap.keys {
            keys.append(key)
        }
        return keys
    }
    
}
