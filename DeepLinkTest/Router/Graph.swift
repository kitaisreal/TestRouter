//
//  Graph.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/4/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation

class Graph<Value> {
    private var mainNode:Node<Value>
    
    init(mainNode:Node<Value>) {
        self.mainNode = mainNode
    }
    
    func printGraphValues() {
        print("Root node")
        mainNode.printNodesValues()
    }
}
class Node<Value> {
    
    private var childNodes:[Node] = []
    private var value:Value
    private var previousNode:Node?
    
    init(value:Value,previousNode:Node?) {
        self.value = value
        self.previousNode = previousNode
    }
    func addNode(node:Node) {
        self.childNodes.append(node)
    }
    func getNodes() -> [Node]{
        return childNodes
    }
    func getValue() -> Value{
        return self.value
    }
    func pathToNode() {
        print(value)
        previousNode?.pathToNode()
    }
    func printNodesValues() {
        for item in childNodes {
            print(item.getValue())
            item.printNodesValues()
        }
    }
}
