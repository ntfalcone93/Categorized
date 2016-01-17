//
//  User.swift
//  Categorized
//
//  Created by Nathan on 1/16/16.
//  Copyright © 2016 FalcOne Development. All rights reserved.
//

import Foundation
import Firebase

class User: NSObject {
    
    var categories: [String] = []
    let ref: Firebase?
    
    override init() {
        self.categories = []
        self.ref = nil
    }
    
    init(snapshot: FDataSnapshot) {
        if let unwrappedCategories = snapshot.value["categories"] as? [String: String] {
            self.categories = Array(unwrappedCategories.values)
        }
        self.ref = snapshot.ref
    }
    
    init(dictionary: [String: AnyObject]) {
        self.categories = dictionary["categories"] as! [String]
        self.ref = nil
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "categories" : self.categories
        ]
    }
}