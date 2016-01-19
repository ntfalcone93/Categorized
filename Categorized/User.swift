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
    
    let email: String
    var categories: [String] = []
    let ref: Firebase?
    
    init(email: String) {
        self.email = email
        self.categories = []
        self.ref = nil
    }
    
    init(snapshot: FDataSnapshot) {
        self.email = snapshot.value["email"] as! String
        if let unwrappedCategories = snapshot.value["categories"] as? [String: AnyObject] {
            self.categories = Array(unwrappedCategories.keys)
        }
        self.ref = snapshot.ref
    }
    
    init(dictionary: [String: AnyObject]) {
        self.email = dictionary["email"] as! String
        self.categories = dictionary["categories"] as! [String]
        self.ref = nil
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "email" : self.email,
            "categories" : self.categories
        ]
    }
}