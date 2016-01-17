//
//  FirebaseController.swift
//  Categorized
//
//  Created by Nathan on 1/16/16.
//  Copyright © 2016 FalcOne Development. All rights reserved.
//

import Foundation
import Firebase

class FirebaseController: NSObject {
    
    static let sharedInstance = FirebaseController()
    let ref = Firebase(url: "https://categorized.firebaseio.com")
    
    
}