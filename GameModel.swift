//
//  Game.swift
//  Minesweeper
//
//  Created by Lavanya Kannan on 11/25/15.
//  Copyright © 2015 Lavanya Kannan. All rights reserved.
//

import UIKit

class GameModel: NSObject {
    var dim: Int
    var mines: [Int]
    
    init(dim: Int, numMines: Int) {
        mines = []
        for _ in 0...numMines-1 {
            var rand = Int(arc4random_uniform(UInt32(dim*dim-1)))
            while mines.contains(rand) {
                rand = Int(arc4random_uniform(UInt32(dim*dim-1)))
            }
            mines.append(rand)
        }
        self.dim = dim
    }
    
    func getNeighborTags(tag: Int) -> [Int] {
        var neighbors = Array<Int>()
        
        var aboveTag = 0
        var belowTag = 0
        
        aboveTag = tag-dim-1
        belowTag = tag+dim-1
        if(tag%dim != 0) {
            neighbors.append(aboveTag)
            neighbors.append(tag-1)
            neighbors.append(belowTag)
        }
        neighbors.append(aboveTag+1)
        neighbors.append(belowTag+1)
        if(tag%dim != dim-1) {
            neighbors.append(aboveTag+2)
            neighbors.append(tag+1)
            neighbors.append(belowTag+2)
        }
        
        var filteredNeighbors = [Int]()
        for tag in neighbors {
            if(tag >= 0 && tag < dim*dim) {
                filteredNeighbors.append(tag)
            }
        }
        
        return filteredNeighbors
    }
    
    func getDisplayValue(tag: Int) -> Int {
        if(mines.contains(tag)) {
            return -1
        }
        
        var count = 0
        let neighbors = getNeighborTags(tag)
        
        for neighborTag in neighbors {
            if(mines.contains(neighborTag)) {
                count += 1
            }
        }
        return count
    }
    
}
