//
//  MasterViewController.swift
//  Project7
//
//  Created by Joe Averbukh on 9/17/15.
//  Copyright © 2015 Joe Averbukh. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [[String: String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = loadPetitions()
        let json = JSON(data: data)
        if json["metadata"]["responseInfo"]["status"].intValue == 200 {
            parseJSON(json)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Business Logic
    
    func loadPetitions() -> NSData {
        var petitions = NSData()
        
        if let petitionsPath = NSBundle.mainBundle().pathForResource("petitions", ofType: "json") {
            do {
                let petitionsFromFile = try NSData(contentsOfFile: petitionsPath, options: [])
                print("Loaded petitions from '\(petitionsPath)'")
                petitions = petitionsFromFile
            } catch _ as NSError {
                print("Error reading '\(petitionsPath)'")
            }
        } else {
            print("Could not find petitions")
        }
        
        return petitions
    }
    
    func parseJSON(json: JSON) {
        for result in json["results"].arrayValue {
            let title = result["title"].stringValue
            let body = result["body"].stringValue
            let sigs = result["signatureCount"].stringValue
            let obj = ["title": title, "body": body, "sigs": sigs]
            objects.append(obj)
        }
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
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
        cell.textLabel!.text = object["title"]
        cell.detailTextLabel!.text = object["body"]
        return cell
    }

}