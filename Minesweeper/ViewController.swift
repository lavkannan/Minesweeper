//
//  ViewController.swift
//  Minesweeper
//
//  Created by Lavanya Kannan on 11/25/15.
//  Copyright © 2015 Lavanya Kannan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var dimension: Int!
    var numMines: Int!
    var game: GameModel!
    var count = 0
    var endGameStatus = ""
    var cells = Array<UIButton>()
    
    @IBOutlet weak var endGameLabel: UILabel!
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        endGameLabel.hidden = true
    }
    
    func loadNewGame(dim: Int, mines: Int) {
        count = 0
        dimension = dim
        numMines = mines
        loadCells(dimension)
        game = GameModel(dim: dimension, numMines: numMines)
    }
    
    func loadCells(dim: Int) {
        let sideLength = view.bounds.width/CGFloat(dim)
        
        var x = CGFloat(0)
        var y = view.bounds.height/5
        var buttonTag = 0
        
        for _ in 0...dim-1 {
            for _ in 0...dim-1 {
                let button = UIButton()
                button.frame = CGRectMake(x, y, sideLength, sideLength)
                button.backgroundColor = UIColor.grayColor()
                button.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
                button.layer.borderWidth = 1
                button.layer.borderColor = UIColor.whiteColor().CGColor
                button.tag = buttonTag
                buttonTag += 1
                cells.append(button)
                view.addSubview(button)
                x += sideLength
            }
            x = CGFloat(0)
            y += sideLength
        }
    }
    
    func buttonClicked(sender: UIButton) {
        sender.backgroundColor = UIColor.redColor()
        if (!recur(sender)) {
            endGameStatus = "Game Over!"
            endGame()
//            performSegueWithIdentifier("EndGameSegue", sender: endGameStatus)
        }
        if (count >= dimension*dimension-numMines-1) {
            endGameStatus = "You Won!"
            endGame()
//            performSegueWithIdentifier("EndGameSegue", sender: endGameStatus)
         }
    }
    
    func endGame() {
        endGameLabel.text = endGameStatus
        endGameLabel.hidden = false
        for button in cells {
            if(game.mines.contains(button.tag)) {
                button.backgroundColor = UIColor.redColor()
                button.setTitle("Mine", forState: UIControlState.Normal)
            }
            button.enabled = false
        }
    }
    
    func recur(sender: UIButton) -> Bool {
        
        if(sender.enabled == false) {
            return true
        }
        count += 1
        
        let tag = sender.tag
        let displayNum = game.getDisplayValue(tag)
        if(displayNum == -1  && sender.backgroundColor == UIColor.redColor()) {
            sender.setTitle("Mine", forState: UIControlState.Normal)
            return false
         }
        sender.backgroundColor = UIColor.blackColor()
        sender.enabled = false
        
        if(displayNum > 0) {
            sender.setTitle(String(displayNum), forState: UIControlState.Normal)
            return true
        }
        
        for nextTag in game.getNeighborTags(tag) {
            if let nextButton = view.viewWithTag(nextTag) as? UIButton {
                if(!recur(nextButton)) {
                    return false
                }
            }
        }
        return true
    }
    
    @IBAction func easyGameButton(sender: UIButton) {
        loadNewGame(8, mines: 8)
        easyButton.hidden = true
        mediumButton.hidden = true
        hardButton.hidden = true
    }
    @IBAction func mediumGameButton(sender: UIButton) {
        loadNewGame(10, mines: 12)
        easyButton.hidden = true
        mediumButton.hidden = true
        hardButton.hidden = true
    }
    @IBAction func hardGameButton(sender: UIButton) {
        loadNewGame(12, mines: 20)
        easyButton.hidden = true
        mediumButton.hidden = true
        hardButton.hidden = true
    }
    @IBAction func newGameButton(sender: UIButton) {
        viewDidLoad()
        viewWillAppear(true)
        loadView()
        easyButton.hidden = false
        mediumButton.hidden = false
        hardButton.hidden = false
        endGameLabel.hidden = true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EndGameSegue" {
            let destination = segue.destinationViewController as! EndGameViewController
            //destination.setLabel(sender as! String)
            destination.result = sender as! String
        }
    }
    
}

