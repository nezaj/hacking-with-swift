//
//  Person.swift
//  Project10
//
//  Created by Joe Averbukh on 9/22/15.
//  Copyright © 2015 Joe Averbukh. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}