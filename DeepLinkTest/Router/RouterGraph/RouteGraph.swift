//
//  RouteGraph.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/5/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation

class RouteGraph {
    
    var nodes:[RouteNode] = []
    
    private var nodesHashMap:[String:Int] = [:]
    
    init() {
        
    }
    
    func addNode(node:RouteNode) {
        self.nodes.append(node)
        nodesHashMap.updateValue(self.nodes.count-1, forKey: node.routeNodeLink)
    }
    
    func addNodes(nodes:[RouteNode]) {
        for node in nodes {
            self.addNode(node: node)
        }
    }
    
    func getLinks() -> [String]{
        var linksArray:[String] = []
        for node in nodes {
            linksArray.append(node.routeNodeLink)
        }
        return linksArray
    }
    
    func removeAllNodes() {
        self.nodes = []
    }
    
    func findPathToNode(from firstNodeLink:String,to secondNodeLink:String) -> [RouteNode]{
        guard   let nodeFromIndex = nodesHashMap[firstNodeLink],
                let nodeToIndex = nodesHashMap[secondNodeLink] else {
            return []
        }
        if (firstNodeLink == secondNodeLink) {
            return []
        }
        let nodeFrom = nodes[nodeFromIndex]
        let nodeTo = nodes[nodeToIndex]
        var nodesHashTable:[String:Bool] = [:]
        for node in nodes {
            nodesHashTable.updateValue(false, forKey: node.routeNodeLink)
        }
        var queue:[RouteNode] = []
        var path:[RouteNode] = []
        queue.append(nodeFrom)
        print("NODE FROM \(nodeFrom.routeNodeLink)")
        print("NODE TO \(nodeTo.routeNodeLink)")
        while(!queue.isEmpty) {
            guard let node = queue.popLast() else {
                return []
            }
            path.append(node)
            path.printPath()
            if (node.routeNodeLink == nodeTo.routeNodeLink) {
                path.printPath()
                if (path.count>1) {
                    path.remove(at: 0)
                }
                return path
            }
            if (node.adjacentEdges.count == 0) {
                _ = path.popLast()
            }
            for edge in node.adjacentEdges {
                print("ADJACENT EDGES COUNT \(node.adjacentEdges.count)")
                let childNode = edge.secondNode
                print("QUEUE APPEND \(childNode.routeNodeLink)")
                queue.append(childNode)
                nodesHashTable[childNode.routeNodeLink] = true
            }
        }
        return []
    }
}

extension Array where Element == RouteNode {
    func printPath() {
        print("PATH")
        for i in self {
            print("Node \(i.routeNodeID)  \(i.routeNodeLink) \(i.routeNodeType)")
        }
    }
}
