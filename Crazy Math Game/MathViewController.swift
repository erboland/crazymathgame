//
//  MathViewController.swift
//  Crazy Math Game
//
//  Created by Ербол Каршыга on 6/8/16.
//  Copyright © 2016 Ербол Каршыга. All rights reserved.
//

import UIKit

class MathViewController: UIViewController {

    @IBOutlet var labelProblem: UILabel!
    @IBOutlet var textfieldSolution: UITextField!
    
    var i: Int!
    var points: Int!
    var numberOfTries: Int!
   @IBAction func buttonBackPressed(sender: UIButton) {
        
    }
    var rightNumber: Int!
    var leftNumber: Int!
    var delegate: MathScoreDelegate!
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadData()
        generateMultiples()
        // Do any additional setup after loading the view.
    }
    
    func loadData() {
      i = 9
      numberOfTries = 0
      points = 0
      
    }
    
    @IBAction func buttonSubmit(sender: UIButton) {
        guard let answer = Int(textfieldSolution.text!) else {
         alertController("No answer!", message: "Please print your answer before pressing Submit button", isBackButton: true)
         return
        }
        
        if answer == leftNumber * rightNumber {
          self.alertController("Congrats!", message: "You have earned 1 point", isBackButton: true)
          points = points + 1
          numberOfTries = numberOfTries + 1
        } else {
            self.alertController("Wrong!",message: "Too bad, you loose 2 points", isBackButton: false)
            points = points - 2
            numberOfTries = numberOfTries + 1
        }
        if self.numberOfTries != 0 {
            if (self.numberOfTries % 5) == 0 {
                i = i + 10
            }
        }

        delegate.updateScore(points)
        generateMultiples()
    }
    
    
    func generateRandomNumber() -> Int {
        
        return Int(arc4random_uniform(UInt32(i)))+1
    }

    func generateMultiples() {
        
     rightNumber = generateRandomNumber()
     leftNumber = generateRandomNumber()
     self.labelProblem.text = "\(rightNumber) X \(leftNumber)"
    }
    func alertController(title:String, message: String, isBackButton: Bool) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let backButton = UIAlertAction(title:"Try again", style: UIAlertActionStyle.Default, handler: nil)
        let okButton = UIAlertAction(title: "Game is over", style: .Default) { (action: UIAlertAction) in self.dismissViewControllerAnimated(true, completion: nil)}
      
            
        if isBackButton == true {
             alertController.addAction(backButton)
        } else {
           alertController.addAction(okButton)
        }
        self.presentViewController(alertController, animated: true, completion: nil)
                }
    }
