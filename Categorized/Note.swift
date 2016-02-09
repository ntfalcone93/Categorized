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
    let dateLastEditedUTCString: String
    var ref: Firebase?
    
    // Converts dateLastEditedUTCString into a date
    var dateLastEdited: NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
        return dateFormatter.dateFromString(dateLastEditedUTCString)!
    }
    
    init(title: String, bodyText: String) {
        self.title = title
        self.bodyText = bodyText
        // Stores the date correctly
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
        let dateString = formatter.stringFromDate(date)
        self.dateLastEditedUTCString = dateString
        
        self.ref = nil
    }
    
    init(dictionary: [String: AnyObject]) {
        self.title = dictionary["title"] as! String
        self.bodyText = dictionary["bodyText"] as! String
        self.dateLastEditedUTCString = dictionary["dateLastEdited"] as! String
        self.ref = nil
    }
    
    init(snapshot: FDataSnapshot) {
        self.title = snapshot.value["title"] as! String
        self.bodyText = snapshot.value["bodyText"] as! String
        self.dateLastEditedUTCString = snapshot.value["dateLastEdited"] as! String
        self.ref = snapshot.ref
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "title" : title,
            "bodyText" : bodyText,
            "dateLastEdited" : dateLastEditedUTCString
        ]
    }
}