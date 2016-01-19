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
    var currentUser: User?
    var usersCategories: [Category] = []
    var notesInCategory: [Note] = []
    
    
    // MARK: Updating Categories and Notes
    func updateNote(bodyText: String, note: Note) {
        note.ref!.childByAppendingPath("bodyText").setValue(bodyText)
        note.ref!.childByAppendingPath("dateLastEdited").setValue("\(NSDate())")
    }
    
    
    // MARK: Creating New Categories and notes
    func createNewCategory(title: String, caption: String) {
        let category = Category(title: title, caption: caption)
        ref.childByAppendingPath("categories").childByAutoId().setValue(category.toAnyObject()) { (error, categoryRef) -> Void in
            if error == nil {
                if let unwrappedUser = self.currentUser {
                    self.addCategoryToUsersCategories(categoryRef.ref!.key, user: unwrappedUser)
                }
            }
        }
    }
    
    func createNewNote(title: String, category: Category) {
        let note = Note(title: title, bodyText: "")
        ref.childByAppendingPath("notes").childByAutoId().setValue(note.toAnyObject()) { (error, noteRef) -> Void in
            if error == nil {
                self.addNoteToCategory(category, noteID: noteRef.ref!.key)
            }
        }
    }
    
    // MARK: Fetching Categories and Notes
    // Categories
    func fetchUsersCategories(user: User, completion:() -> ()) {
        usersCategories.removeAll()
        let userCategoriesRef = user.ref!.childByAppendingPath("categories")
        userCategoriesRef.queryOrderedByValue().observeEventType(.Value, withBlock: {(snapshot) -> Void in
            let categoryIDs = snapshot.children.allObjects
            for categoryID in categoryIDs {
                self.fetchCategoryWithCategoryID(categoryID.ref!.key, completion: { (category) -> () in
                    if let unwrappedCategory = category {
                        self.usersCategories.append(unwrappedCategory)
                    }
                    if categoryID.ref!.key == categoryIDs.last!.ref!.key {
                        completion()
                    }
                })
            }
        })
    }
    
    // Fetches category with categoryID
    func fetchCategoryWithCategoryID(categoryID: String, completion:(Category?) -> ()) {
        let categoryRef = ref.childByAppendingPath("categories").childByAppendingPath(categoryID)
        categoryRef.observeSingleEventOfType(.Value, withBlock: {(snapshot) -> Void in
            
            let category = Category(snapshot: snapshot)
            completion(category)
        })
        // TODO: Do I need this       completion(nil)
    }
    
    // Notes
    func fetchCategoriesNotes(category: Category, completion:() -> ()) {
        notesInCategory.removeAll()
        let notesRef = category.ref!.childByAppendingPath("notes")
        notesRef.queryOrderedByValue().observeEventType(.Value, withBlock: {(snapshot) -> Void in
            let noteIDs = snapshot.children.allObjects
            for noteID in noteIDs {
                self.fetchNoteWithNoteID(noteID.ref!.key, completion: { (note) -> () in
                    if let unwrappedNote = note {
                        self.notesInCategory.append(unwrappedNote)
                    }
                    if noteID.ref!.key == noteIDs.last!.ref!.key {
                        completion()
                    }
                })
            }
        })
    }
    
    // Fetches category with categoryID
    func fetchNoteWithNoteID(noteID: String, completion:(Note?) -> ()) {
        let noteRef = ref.childByAppendingPath("notes").childByAppendingPath(noteID)
        noteRef.observeSingleEventOfType(.Value, withBlock: {(snapshot) -> Void in
            
            let note = Note(snapshot: snapshot)
            completion(note)
        })
        // TODO: Do I need this       completion(nil)
    }
    
    
    // MARK: Creating and Fetching Users
    // Fetches the current user
    func fetchCurrentUser(completion:(authData:FAuthData?)->()){
        if let unwrappedCurrentUser = NSUserDefaults.standardUserDefaults().objectForKey("userID") as? String{
            self.ref.childByAppendingPath(unwrappedCurrentUser).observeAuthEventWithBlock { authData in
                if authData != nil {
                    self.retrieveCurrentUserWithUserID(authData.uid, completion: { (user) -> () in
                        self.currentUser = user
                        completion(authData: authData)
                    })
                } else {
                    completion(authData: nil)
                }
            }
        } else {
            completion(authData: nil)
        }
    }
    
    func retrieveCurrentUserWithUserID(userID: String, completion: (User?) ->()) {
        ref.childByAppendingPath("users").childByAppendingPath(userID).observeSingleEventOfType(.Value, withBlock: { (snapshot) -> Void in
            if let userSnapshot = snapshot {
                let user = User.init(snapshot: userSnapshot)
                completion(user)
            } else {
                print("Error retrieving user with user ID: \(userID)")
                completion(nil)
            }
        })
    }
    
    // MARK: Adding and Removing Categories and Notes
    // Categories
    func addCategoryToUsersCategories(categoryID: String, user: User) {
        ref.childByAppendingPath("users").childByAppendingPath(user.ref!.key).childByAppendingPath("categories").childByAppendingPath(categoryID).setValue(true)
    }
    
    func removeCategoryFromUsersCategories(category: Category, user: User) {
        ref.childByAppendingPath("users").childByAppendingPath(user.ref!.key).childByAppendingPath("categories").childByAppendingPath(category.ref!.key).removeValue()
    }
    
    // Notes
    func addNoteToCategory(category: Category, noteID: String) {
        ref.childByAppendingPath("categories").childByAppendingPath(category.ref!.key).childByAppendingPath("notes").childByAppendingPath(noteID).setValue(true)
    }
    
    func removeNoteFromCategory(category: Category, note: Note) {
        ref.childByAppendingPath("categories").childByAppendingPath(category.ref!.key).childByAppendingPath("notes").childByAppendingPath(note.ref!.key).removeValue()
    }
    
    
    // MARK: User creation
    // Create new user
    func createUserInFirebase(email: String, password: String) {
        // create user
        ref.createUser(email, password: password, withCompletionBlock: { (error) -> Void in
            if error == nil {
                self.ref.authUser(email, password: password, withCompletionBlock: { (error, auth) -> Void in
                    if error == nil {
                        let user = User(email: email)
                        // Create user and lets us use the newly create UID
                        self.ref.childByAppendingPath("users").childByAppendingPath(auth.uid).setValue(user.toAnyObject(), withCompletionBlock: { (error, userRef) -> Void in
                            // Use the users newly created firebase ref to give them some stock categories
                            if error == nil {
                                // Sets userID in NSUserDefaults making it easier for user to login
                                NSUserDefaults.standardUserDefaults().setObject(auth.uid, forKey: "userID")
                                // Gives them a home category
                                self.createHomeCategory({ (firebase) -> () in
                                    if let ref = firebase {
                                        userRef.childByAppendingPath("categories").childByAppendingPath("\(ref.key)").setValue(true)
                                    }
                                })
                                // Gives them a work category
                                self.createWorkCategory({ (firebase) -> () in
                                    if let ref = firebase {
                                        userRef.childByAppendingPath("categories").childByAppendingPath("\(ref.key)").setValue(true)
                                    }
                                })
                            } else {
                                print("Error setting users properties: \(error.localizedDescription)")
                            }
                        })
                    } else {
                        print("Error while authenticating user: \(error.localizedDescription)")
                    }
                })
            } else {
                print("Error while creating user: \(error.localizedDescription)")
            }
        })
    }
    
    // Stock categories when user first creates an account
    func createHomeCategory(completion: (Firebase?) -> ()) {
        let homeCategory = Category(title: "Home", caption: "")
        ref.childByAppendingPath("categories").childByAutoId().setValue(homeCategory.toAnyObject()) { (error, firebaseRef) -> Void in
            if error == nil {
                let note = Note(title: "New note", bodyText: "")
                self.ref.childByAppendingPath("notes").childByAutoId().setValue(note.toAnyObject(), withCompletionBlock: { (error, noteRef) -> Void in
                    if error == nil {
                        firebaseRef.childByAppendingPath("notes").childByAppendingPath(noteRef.key).setValue(true)
                    }
                })
                completion(firebaseRef)
            } else {
                completion(nil)
            }
        }
        completion(nil)
    }
    func createWorkCategory(completion: (Firebase?) -> ()) {
        let workCategory = Category(title: "Work", caption: "")
        ref.childByAppendingPath("categories").childByAutoId().setValue(workCategory.toAnyObject()) { (error, firebaseRef) -> Void in
            if error == nil {
                let note = Note(title: "New note", bodyText: "")
                self.ref.childByAppendingPath("notes").childByAutoId().setValue(note.toAnyObject(), withCompletionBlock: { (error, noteRef) -> Void in
                    if error == nil {
                        firebaseRef.childByAppendingPath("notes").childByAppendingPath(noteRef.key).setValue(true)
                    }
                })
                completion(firebaseRef)
            } else {
                completion(nil)
            }
        }
        completion(nil)
    }
}