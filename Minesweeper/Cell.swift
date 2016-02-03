//
//  Cell.swift
//  Minesweeper
//
//  Created by Lavanya Kannan on 11/25/15.
//  Copyright © 2015 Lavanya Kannan. All rights reserved.
//

import UIKit

class Cell: NSObject {
    var row: Int
    var col: Int
    var neighbors = [[Int]]()
    var hasMine: Bool = false
    
    init(r: Int, c:Int) {
        row = r
        col = c
    }
    
    func getNeighbors() {
//        neighbors.append([Int]())
        
    }
}
