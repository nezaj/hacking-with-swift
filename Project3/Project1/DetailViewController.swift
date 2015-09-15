//
//  DetailViewController.swift
//  Project1
//
//  Created by Joe Averbukh on 9/3/15.
//  Copyright © 2015 Joe Averbukh. All rights reserved.
//

import UIKit
import Social

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!

    var detailItem: String?

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            self.title = detail
            if let imageView = self.detailImageView {
                imageView.image = UIImage(named: detail)
            }
        }
    }
    
    func shareTapped() {
        let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        vc.setInitialText("Look at this picture")
        vc.addImage(detailImageView.image!)
        vc.addURL(NSURL(string: "http://www.photolib.noaa.gov/nssl"))
        presentViewController(vc, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self,
            action: "shareTapped")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}