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
    let dateLastEditedUTCString: String
    var notes: [String] = []
    var ref: Firebase?
    
    // Converts dateLastEditedUTCString into a date
    var dateLastEdited: NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
        return dateFormatter.dateFromString(dateLastEditedUTCString)!
    }

    init(title: String, caption: String) {
        self.title = title
        self.caption = caption
        // Stores the date correctly
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
        let dateString = formatter.stringFromDate(date)
        self.dateLastEditedUTCString = dateString
        
        self.notes = []
        self.ref = nil
    }
    
    init(snapshot: FDataSnapshot) {
        self.title = snapshot.value["title"] as! String
        self.caption = snapshot.value["caption"] as! String
        self.dateLastEditedUTCString = snapshot.value["dateLastEdited"] as! String
        if let unwrappedNotes = snapshot.value["notes"] as? [String: AnyObject] {
            self.notes = Array(unwrappedNotes.keys)
        }
        self.ref = snapshot.ref
    }
    
    init(dictionary: [String: AnyObject]) {
        self.title = dictionary["title"] as! String
        self.caption = dictionary["caption"] as! String
        self.dateLastEditedUTCString = dictionary["dateLastEdited"] as! String
        self.notes = dictionary["notes"] as! [String]
        self.ref = nil
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "title" : title,
            "caption" : caption,
            "dateLastEdited" : dateLastEditedUTCString,
            "notes" : notes
        ]
    }
}