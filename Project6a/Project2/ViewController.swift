//
//  ViewController.swift
//  Project2
//
//  Created by Joe Averbukh on 9/14/15.
//  Copyright © 2015 Joe Averbukh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!

    @IBOutlet weak var scoreLabel: UILabel!

    var countries = [
        "estonia",
        "france",
        "germany",
        "ireland",
        "italy",
        "monaco",
        "nigeria",
        "poland",
        "russia",
        "spain",
        "uk",
        "us"
    ]
    var score = 0
    var correctAnswer = 0
    let flagBorderWidth: CGFloat = 1
    let flagBorderColor = UIColor.blackColor().CGColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        playGame()
    }
    
    func playGame(action: UIAlertAction! = nil) {
        drawFlags()
        drawScore()
        askQuestion()
    }
    
    func drawFlags() {
        countries.shuffle()
        for (idx, button) in [button1, button2, button3].enumerate() {
            button.layer.borderWidth = flagBorderWidth
            button.layer.borderColor = flagBorderColor
            button.setImage(UIImage(named: countries[idx]), forState: .Normal)
        }
    }
    
    func drawScore() {
        scoreLabel.text = "Score: \(score)"
    }

    func askQuestion() {
        correctAnswer = Int(arc4random_uniform(3))
        title = countries[correctAnswer].uppercaseString
    }
    
    @IBAction func buttonTapped(sender: UIButton) {
        if sender.tag == correctAnswer {
            ++score
        } else {
            --score
        }
        
        playGame()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}