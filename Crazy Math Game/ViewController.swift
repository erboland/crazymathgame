//
//  ViewController.swift
//  Crazy Math Game
//
//  Created by Ербол Каршыга on 6/8/16.
//  Copyright © 2016 Ербол Каршыга. All rights reserved.
//

import UIKit

protocol MathScoreDelegate {
    func updateScore(points: Int, pointsTwo: Int, winner: String?, score: Int)
}

class ViewController: UIViewController, MathScoreDelegate {

    @IBOutlet var labelScore: UILabel!
    @IBOutlet var labelScoreTwo: UILabel!
    @IBOutlet var labelWinner: UILabel!
    var winner: String?
    var score: [Int!] = []
    var reversed: [Int!] = []

    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {}
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let score = NSUserDefaults.standardUserDefaults().arrayForKey("results") as? [Int!] {
            self.score = score
            reversed = self.score.sort( {(s1: Int!, s2: Int!) -> Bool in return s1 > s2} )
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
            labelWinner.text = "Who would be the winner?"
       
        
        
        if let score = NSUserDefaults.standardUserDefaults().objectForKey("score") {
            labelScore.text = "User one, your score is: \(score as! Int)"
        } else {
           labelScore.text = "Welcome to the game!"
            NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "score")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        if let scoreTwo = NSUserDefaults.standardUserDefaults().objectForKey("scoreTwo") {
            labelScoreTwo.text = "User two, your score is: \(scoreTwo as! Int)"
        } else {
            labelScoreTwo.text = "Just Do It!"
            NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "scoreTwo")
            NSUserDefaults.standardUserDefaults().synchronize()
        }

    }
    
    
    @IBAction func buttonReset(sender: UIButton) {
       NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "score")
       labelScore.text = String("User one, your score is: \(NSUserDefaults.standardUserDefaults().objectForKey("score")!)")
        NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "scoreTwo")
        labelScoreTwo.text = String("User two, your score is: \(NSUserDefaults.standardUserDefaults().objectForKey("scoreTwo")!)")
        labelWinner.text = "Who would be the winner?"
        
    }
    
    
    @IBAction func buttonSeeResultsPressed(sender: UIButton) {
        self.performSegueWithIdentifier("SegueResults", sender: nil)
    }
    
    @IBAction func buttonFightPressed(sender: UIButton) {
        self.performSegueWithIdentifier("SegueFight", sender: nil)
    }
 
    
    @IBAction func buttonExtraPressed(sender: UIButton) {
        self.performSegueWithIdentifier("SegueGame", sender: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SegueResults" {
          let resultsTVC = segue.destinationViewController as! ResultsTableViewController
           resultsTVC.results = self.reversed
        
        }
        if segue.identifier == "SegueGame" {
          let mathVC = segue.destinationViewController as! MathViewController
          mathVC.delegate = self
        } else if segue.identifier == "SegueFight" {
            let mathVC = segue.destinationViewController as! MathViewController
            mathVC.delegate = self
        }
    }
    
    func updateScore(points: Int, pointsTwo: Int, winner: String?, score: Int) {
        let currentScore = NSUserDefaults.standardUserDefaults().integerForKey("score") + points
        NSUserDefaults.standardUserDefaults().setInteger(currentScore, forKey: "score")
        NSUserDefaults.standardUserDefaults().synchronize()
        labelScore.text = "Your score is: \(currentScore)"
        //FOR USER TWO
        let currentScoreTwo = NSUserDefaults.standardUserDefaults().integerForKey("scoreTwo") + pointsTwo
        NSUserDefaults.standardUserDefaults().setInteger(currentScoreTwo, forKey: "scoreTwo")
        NSUserDefaults.standardUserDefaults().synchronize()
        labelScoreTwo.text = "Your score is: \(currentScoreTwo)"
        labelWinner.text = winner
        self.score.append(score)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(self.score, forKey: "results")
        defaults.synchronize()
        
    }
}

