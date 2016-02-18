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
    //    let ref = Firebase.defaultConfig()
    
    let ref = Firebase(url: "https://categorized.firebaseio.com")
    var currentUser: User?
    var usersCategories: [Category] = []
    var notesInCategory: [Note] = []
    
    //    func ref() -> Firebase {
    //        Firebase.defaultConfig().persistenceEnabled = true
    //        return Firebase(url: "https://categorized.firebaseio.com")
    //    }
    
    // MARK: Updating Categories and Notes
    func updateNote(bodyText: String, note: Note, category: Category) {
        note.ref!.childByAppendingPath("bodyText").setValue(bodyText)
        // Updates dateLastEdited with a formatted date
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
        let dateString = formatter.stringFromDate(date)
        // Updates note
        note.ref!.childByAppendingPath("dateLastEdited").setValue(dateString)
        // Updates category
        category.ref!.childByAppendingPath("dateLastEdited").setValue(dateString)
    }
    
    func updateCategoriesDateLastEdited(category: Category) {
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
        let dateString = formatter.stringFromDate(date)
        category.ref!.childByAppendingPath("dateLastEdited").setValue(dateString)
    }
    
    
    // MARK: Creating New Categories and notes
    func createNewCategory(title: String, caption: String, completion: () -> ()) {
        let category = Category(title: title, caption: caption)
        ref.childByAppendingPath("categories").childByAutoId().setValue(category.toAnyObject()) { (error, categoryRef) -> Void in
            if error == nil {
                if let unwrappedUser = self.currentUser {
                    self.addCategoryToUsersCategories(categoryRef.ref!.key, user: unwrappedUser)
                    category.ref = categoryRef
                    self.usersCategories.append(category)
                    completion()
                }
            } else {
                print("Error creating category: \(error.localizedDescription)")
                completion()
            }
        }
    }
    
    func createNewNote(title: String, category: Category, completion: () -> ()) {
        let note = Note(title: title, bodyText: "")
        ref.childByAppendingPath("notes").childByAutoId().setValue(note.toAnyObject()) { (error, noteRef) -> Void in
            if error == nil {
                self.addNoteToCategory(category, noteID: noteRef.ref!.key)
                note.ref = noteRef
                self.notesInCategory.append(note)
                completion()
            } else {
                print("Error creating note: \(error.localizedDescription)")
                completion()
            }
        }
    }
    
    // MARK: Deleting Notes and Categories
    func deleteCategory(category: Category, user: User) {
        // Deletes category from Firebase
        category.ref!.removeValue()
        // Delete each one of the categoryies notes
        for noteID in category.notes {
            deleteNoteWithID(noteID)
        }
        // Deletes the category ref from the users array of categories
        removeCategoryFromUsersCategories(category, user: user)
    }
    
    func deleteNote(note: Note, category: Category) {
        // Deletes note from Firebase
        note.ref!.removeValue()
        // Deletes the note ref from the categories array of notes
        removeNoteFromCategory(category, note: note)
    }
    
    func deleteNoteWithID(noteID: String) {
        ref.childByAppendingPath("notes").childByAppendingPath(noteID).removeValue()
    }
    
    // MARK: Fetching Categories and Notes
    // Categories
    func fetchUsersCategories(user: User, completion:() -> ()) {
        usersCategories.removeAll()
        let userCategoriesRef = user.ref!.childByAppendingPath("categories")
        userCategoriesRef.queryOrderedByValue().observeSingleEventOfType(.Value, withBlock: {(snapshot) -> Void in
            let categoryIDs = snapshot.children.allObjects
            for categoryID in categoryIDs {
                self.fetchCategoryWithCategoryID(categoryID.ref!.key, completion: { (category) -> () in
                    if let unwrappedCategory = category {
                        self.usersCategories.append(unwrappedCategory)
                    }
                    if categoryID.ref!.key == categoryIDs.last!.ref!.key {
                        self.usersCategories.sortInPlace({$0.dateLastEditedUTCString > $1.dateLastEditedUTCString})
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
    }
    
    // Notes
    func fetchCategoriesNotes(category: Category, completion:() -> ()) {
        notesInCategory.removeAll()
        let notesRef = category.ref!.childByAppendingPath("notes")
        notesRef.queryOrderedByValue().observeSingleEventOfType(.Value, withBlock: {(snapshot) -> Void in
            let noteIDs = snapshot.children.allObjects
            for noteID in noteIDs {
                self.fetchNoteWithNoteID(noteID.ref!.key, completion: { (note) -> () in
                    if let unwrappedNote = note {
                        self.notesInCategory.append(unwrappedNote)
                    }
                    if noteID.ref!.key == noteIDs.last!.ref!.key {
                        self.notesInCategory.sortInPlace({$0.dateLastEditedUTCString > $1.dateLastEditedUTCString})
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
    
    //
    func wipeArraysForNewUser() {
        self.usersCategories.removeAll()
        self.notesInCategory.removeAll()
    }
    
    // MARK: User creation
    // Create new user
    func createUserInFirebase(email: String, password: String, completion: () -> ()) {
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
                                completion()
                                
                            } else {
                                print("Error setting users properties: \(error.localizedDescription)")
                                completion()
                            }
                        })
                    } else {
                        print("Error while authenticating user: \(error.localizedDescription)")
                        completion()
                    }
                })
            } else {
                print("Error while creating user: \(error.localizedDescription)")
                completion()
            }
        })
    }
    
    func deleteUserFromFirebase(user: User, email: String, password: String, completion: () -> ()) {
        // Delete all of the users data
        ref.removeUser(email, password: password) { (error) -> Void in
            if error == nil {
                self.ref.childByAppendingPath("users").childByAppendingPath(user.ref!.key).removeValue()
                completion()
            } else {
                print("There was an error while removing the user from Firebase: \(error.localizedDescription)")
                completion()
            }
        }
    }
}
/*
// Need to finish this method
func deleteUserFromFirebase(user: User, email: String, password: String, completion: () -> ()) {
// Delete all of the users data
ref.removeUser(email, password: password) { (error) -> Void in
if error == nil {
// Fetches all of the users categories from firebase
user.ref!.childByAppendingPath("categories").observeSingleEventOfType(.Value, withBlock: {(snapshot) -> Void in
let allCategoryObjects = snapshot.children.allObjects
for categoryId in allCategoryObjects {
self.fetchCategoryWithCategoryID(categoryId.ref!.key, completion: { (category) -> () in
if let unwrappedCategory = category {
// Fetches all of the categories notes from firebase
unwrappedCategory.ref!.childByAppendingPath("notes").observeSingleEventOfType(.Value, withBlock: {(snapshot) -> Void in
let allNoteObjects = snapshot.children.allObjects
for noteId in allNoteObjects {
self.fetchNoteWithNoteID(noteId.ref!.key, completion: { (note) -> () in
if let unwrappedNote = note {
unwrappedNote.ref?.removeValue()
}
})
if let noteString = noteId as? String, lastNoteString = allNoteObjects.last as? String {
if noteString == lastNoteString {
if let categoryString = categoryId as? String, lastCategoryString = allCategoryObjects.last as? String {
if categoryString == lastCategoryString {
if let user = self.currentUser {
self.ref.childByAppendingPath("users").childByAppendingPath(user.ref!.key).removeValue()
completion()
}
}
}
}
}
}
})
unwrappedCategory.ref!.removeValue()
}
})
}
})
} else {
print("There was an error while removing the user from Firebase: \(error.localizedDescription)")
completion()
}
}
}
*/