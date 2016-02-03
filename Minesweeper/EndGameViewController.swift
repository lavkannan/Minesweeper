//
//  EndGameViewController.swift
//  Minesweeper
//
//  Created by Lavanya Kannan on 11/26/15.
//  Copyright © 2015 Lavanya Kannan. All rights reserved.
//

import UIKit

class EndGameViewController: UIViewController {
    @IBOutlet var endGameLabel: UILabel!
    var result: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        endGameLabel.text = result
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func newGame(sender: UIButton) {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
