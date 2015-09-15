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
    
    func askQuestion() {
        correctAnswer = Int(arc4random_uniform(3))
        title = countries[correctAnswer].uppercaseString
    }
    
    @IBAction func buttonTapped(sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            ++score
        } else {
            title = "Wrong"
            --score
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .Default, handler: playGame))
        presentViewController(ac, animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}