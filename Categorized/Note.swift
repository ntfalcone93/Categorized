//
//  Note.swift
//  Categorized
//
//  Created by Nathan on 1/16/16.
//  Copyright © 2016 FalcOne Development. All rights reserved.
//

import Foundation
import Firebase

class Note: NSObject {
    
    let title: String
    let bodyText: String
    let dateLastEdited: String
//    let categoryID: String
    let ref: Firebase?
    
    init(title: String, bodyText: String) {
        self.title = title
        self.bodyText = bodyText
        self.dateLastEdited = "\(NSDate())"
        self.ref = nil
    }
    
    init(dictionary: [String: AnyObject]) {
        self.title = dictionary["title"] as! String
        self.bodyText = dictionary["bodyText"] as! String
        self.dateLastEdited = dictionary["dateLastEdited"] as! String
        self.ref = nil
    }
    
    init(snapshot: FDataSnapshot) {
        self.title = snapshot.value["title"] as! String
        self.bodyText = snapshot.value["bodyText"] as! String
        self.dateLastEdited = snapshot.value["dateLastEdited"] as! String
        self.ref = snapshot.ref
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "title" : title,
            "bodyText" : bodyText,
            "dateLastEdited" : dateLastEdited
        ]
    }
}