//
//  MazeStructure.swift
//  MAZER
//
//  Created by Daniel Kouba on 12/22/16.
//  Copyright © 2016 Daniel Kouba. All rights reserved.
//

import UIKit

////////////////////////////////////////
// MARK: - Node Class
////////////////////////////////////////
//This is SOLID
class Node{
    
    var top: Node?
    var left: Node?
    var right: Node?
    var bottom: Node?
    var parent: Node?
    var h: Int?
    var f: Int?
    var g: Int?
    var coord: (Int, Int)?
    var value: Int?
    var index: Int?
    var button: UIButton?
    
    
    init(index: Int, coord:(Int, Int), value: Int){
        self.coord = coord
        self.value = value
        self.index = index
        self.g = 10 //this is only true if not using diagonal
    }
    
    
}




////////////////////////////////////////
// MARK: - Graph Class
////////////////////////////////////////
// MARK: - This is WEAK
class Graph{
    var start: Node?
    var end: Node?
    var width: Int?
    var first: Node?
    var last: Node?
    var list: [Node]?
    var openlist: [Node]?
    var closedlist: [Node]?
    
    
    
    func create(array: [Int]){
        //Create Node Array
        var nodeArray = [[Node]]()
        //Do only for the width
        for y in 0...((array.count - 1)/self.width!){
            let bottom = self.width! * y
            let top = self.width! + bottom
            //            print(array[bottom..<top])
            nodeArray.append([])
            
            for idx in bottom..<top{
                let x = idx%self.width!
                //Create New Node
                let newNode = Node(index: idx, coord: (x,y), value: array[idx])
                //Append it to Node Array
                nodeArray[y].append(newNode)
                self.list?.append(newNode)
            }
        }
        for y in 0..<nodeArray.count {
            for x in 0..<nodeArray[y].count{
                //Write First
                if x == 0 && y == 0 {
                    self.first = nodeArray[0][0]
                }
                //Write Last
                if x == nodeArray[0].count - 1 && y == nodeArray.count - 1 {
                    self.last = nodeArray[y][x]
                }
                
                //Write Start
                if nodeArray[y][x].value! == 1{
                    self.start = nodeArray[y][x]
                }
                //Write End
                if nodeArray[y][x].value! == 2{
                    self.end = nodeArray[y][x]
                }
                
                //Write Top Relationship
                if ((y - 1) >= 0 ) && ((y - 1) < nodeArray.count){
                    nodeArray[y][x].top = nodeArray[y - 1][x]
                } else {
                    nodeArray[y][x].top = nil
                }
                
                //Write Left Relationship
                if ((x - 1) >= 0 ) && ((x - 1) < nodeArray[y].count){
                    nodeArray[y][x].left = nodeArray[y][x - 1]
                } else {
                    nodeArray[y][x].left = nil
                }
                
                //Write Right Relationship
                if ((x + 1) >= 0 ) && ((x + 1) < nodeArray[y].count){
                    nodeArray[y][x].right = nodeArray[y][x + 1]
                } else {
                    nodeArray[y][x].right = nil
                }
                
                //Write Bottom Relationship
                if ((y + 1) >= 0 ) && ((y + 1) < nodeArray.count){
                    nodeArray[y][x].bottom = nodeArray[y+1][x]
                } else {
                    nodeArray[y][x].bottom = nil
                }
            }
        }
    }
    
    
    
    init(width: Int, array: [Int]){
        self.width = width
        self.list = [Node]()
        self.openlist = [Node]()
        self.closedlist = [Node]()
        create(array)
    }
    
}



