//
//  MasterViewController.swift
//  Project5
//
//  Created by Joe Averbukh on 9/16/15.
//  Copyright © 2015 Joe Averbukh. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var objects = [String]()
    var allWords = [String]()


    // MARK: Built-ins
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add,
            target: self, action: "promptForAnswer")
        initAllWords()
        startGame()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Business logic
    
    func initAllWords() {
        if let startWordsPath = NSBundle.mainBundle().pathForResource("start", ofType: "txt") {
            do {
                let startWords = try NSString(contentsOfFile: startWordsPath, usedEncoding: nil)
                allWords = startWords.componentsSeparatedByString("\n")
                print("Using words from '\(startWordsPath)'")
            } catch _ as NSError {
                print("Error reading '\(startWordsPath)' using default words instead")
                allWords = useDefaultWords()
            }
        } else {
            print("Could not find words file, using default words instead")
            allWords = useDefaultWords()
        }
    }
    
    func promptForAnswer() {
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .Alert)
        ac.addTextFieldWithConfigurationHandler(nil)
        
        let submitAction = UIAlertAction(title: "Submit", style: .Default) { [unowned self, ac] _ in
            let answer = ac.textFields![0]
            self.submitAnswer(answer.text!)
        }
        
        ac.addAction(submitAction)
        presentViewController(ac, animated: true, completion: nil)
    }
    
    func showErrorMessage(alertTitle: String, alertMessage: String) {
        let ac = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
    }
    
    func startGame() {
        allWords.shuffle()
        title = allWords[0]
        objects.removeAll(keepCapacity: true)
        tableView.reloadData()
    }
    
    func submitAnswer(answer: String) {
        let lowerAnswer = answer.lowercaseString
        let original = title!.lowercaseString
        
        if lowerAnswer == original {
            return showErrorMessage("Original word used!",
                alertMessage: "You can't use the original word as your answer!")
        }
        
        if !wordIsPossible(lowerAnswer, original: original) {
            return showErrorMessage("Word not possible",
                alertMessage: "You can't spell '\(lowerAnswer)' from '\(title!.lowercaseString)'!")
        }
        
        if !wordIsOriginal(lowerAnswer) {
            return showErrorMessage("Word used already", alertMessage: "Be more original!")
        }
        
        if !wordIsReal(lowerAnswer) {
            return showErrorMessage("Word not recognized", alertMessage: "You can't just make them up you know!")
        }
        
        objects.insert(answer, atIndex: 0)
        
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    func useDefaultWords() -> [String] {
        return ["silkworm"]
    }
    
    func wordIsOriginal(word: String) -> Bool {
        return !objects.contains(word)
    }
    
    func wordIsPossible(word: String, original: String) -> Bool {
        // Check to see if "word" is possible from original
        var cleanOriginal = original.lowercaseString
        
        if word.characters.count > cleanOriginal.characters.count {
            return false
        }
        
        for letter in word.characters {
            if let pos = cleanOriginal.rangeOfString(String(letter)) {
                if pos.isEmpty {
                    return false
                } else {
                    cleanOriginal.removeAtIndex(pos.startIndex)
                }
            } else {
                return false
            }
        }
        
        return true
    }
    
    func wordIsReal(word: String) -> Bool {
        // Small words not allowed!
        if word.characters.count < 3 {
            return false
        }
        
        let checker = UITextChecker()
        let range = NSMakeRange(0, word.characters.count)
        let misspelledRange = checker.rangeOfMisspelledWordInString(word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }

    // MARK: - Table View
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = objects[indexPath.row]
        cell.textLabel!.text = object
        return cell
    }

}