//
//  Category.swift
//  Categorized
//
//  Created by Nathan on 1/16/16.
//  Copyright © 2016 FalcOne Development. All rights reserved.
//

import Foundation
import Firebase

class Category: NSObject {
    
    let title: String
    let caption: String
    let dateLastEdited: String
    var notes: [String] = []
    let ref: Firebase?
    
    init(title: String, caption: String) {
        self.title = title
        self.caption = caption
        self.dateLastEdited = "\(NSDate())"
        self.notes = []
        self.ref = nil
    }
    
    init(snapshot: FDataSnapshot) {
        self.title = snapshot.value["title"] as! String
        self.caption = snapshot.value["caption"] as! String
        self.dateLastEdited = snapshot.value["dateLastEdited"] as! String
        if let unwrappedNotes = snapshot.value["notes"] as? [String: AnyObject] {
            self.notes = Array(unwrappedNotes.keys)
        }
        self.ref = snapshot.ref
    }
    
    init(dictionary: [String: AnyObject]) {
        self.title = dictionary["title"] as! String
        self.caption = dictionary["caption"] as! String
        self.dateLastEdited = dictionary["dateLastEdited"] as! String
        self.notes = dictionary["notes"] as! [String]
        self.ref = nil
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "title" : title,
            "caption" : caption,
            "dateLastEdited" : dateLastEdited,
            "notes" : notes
        ]
    }
}