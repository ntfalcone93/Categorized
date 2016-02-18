//
//  UIAlerts.swift
//  Categorized
//
//  Created by Nathan on 1/18/16.
//  Copyright © 2016 FalcOne Development. All rights reserved.
//

import Foundation
import UIKit
import Firebase

extension UIAlertController {
    
    // Alert for sharing notes
    class func displayShareSheet(target: UIViewController, note: Note) {
        let activityViewController = UIActivityViewController(activityItems: [note.title, note.bodyText], applicationActivities: nil)
        target.presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    // MARK: Alerts for creating categories and notes
    // Alert for creating new category
    class func createNewCategory(target: UIViewController, completion:() -> ()) {
        let alertController = UIAlertController(title: "New Category", message: "Create a new category with a title and caption", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in
            completion()
        }
        
        let createAction = UIAlertAction(title: "Create", style: .Default) { (action) -> Void in
            let titleTextField = alertController.textFields![0]
            let captionTextField = alertController.textFields![1]
            
            if titleTextField.text != "" {
                if let title = titleTextField.text, let caption = captionTextField.text {
                    FirebaseController.sharedInstance.createNewCategory(title, caption: caption, completion: { () -> () in
                        completion()
                    })
                }
            } else {
                self.categoryTitleTextFieldEmpty(target)
                completion()
            }
        }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Title"
            textField.autocapitalizationType = .Sentences
            textField.autocorrectionType = .Yes
            textField.spellCheckingType = .Yes
        }
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Caption"
            textField.autocapitalizationType = .Sentences
            textField.autocorrectionType = .Yes
            textField.spellCheckingType = .Yes
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(createAction)
        
        target.presentViewController(alertController, animated: true, completion: nil)
    }
    // Alert for when user does not enter a title before trying to create
    class func categoryTitleTextFieldEmpty(target: UIViewController) {
        let alertController = UIAlertController(title: "Oops", message: "A category must at least have a title", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
            self.createNewCategory(target, completion: { () -> () in
                //
            })
        }
        
        alertController.addAction(okAction)
        
        target.presentViewController(alertController, animated: true, completion: nil)
    }
    
    class func createNewNote(target: UIViewController, category: Category, completion:() -> ()) {
        let alertController = UIAlertController(title: "New Note", message: "Create a new note with a title", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in
            completion()
        }
        
        let createAction = UIAlertAction(title: "Create", style: .Default) { (action) -> Void in
            let titleTextField = alertController.textFields![0]
            if titleTextField.text != "" {
                if let title = titleTextField.text {
                    FirebaseController.sharedInstance.createNewNote(title, category: category, completion: { () -> () in
                        completion()
                    })
                }
            } else {
                self.noteTitleTextFieldEmpty(target, category: category)
                completion()
            }
        }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Title"
            textField.autocapitalizationType = .Sentences
            textField.autocorrectionType = .Yes
            textField.spellCheckingType = .Yes
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(createAction)
        
        target.presentViewController(alertController, animated: true, completion: nil)
    }
    
    class func noteTitleTextFieldEmpty(target: UIViewController, category: Category) {
        let alertController = UIAlertController(title: "Oops", message: "A note must have a title", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
            self.createNewNote(target, category: category, completion: { () -> () in
                //
            })
        }
        
        alertController.addAction(okAction)
        
        target.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: Login Alerts
    class func invalidLoginAlert(target:UIViewController){
        
        let alert = UIAlertController(title: "Invalid username or password",
            message: "Please enter a valid username or password",
            preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Ok",
            style: .Default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addAction(cancelAction)
        
        target.presentViewController(alert,
            animated: true,
            completion: nil)
    }
    
    // MARK: Login Alerts
    class func connectionErrorAlert(target:UIViewController){
        
        let alert = UIAlertController(title: "Connection Error",
            message: "Please try again",
            preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Ok",
            style: .Default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addAction(cancelAction)
        
        target.presentViewController(alert,
            animated: true,
            completion: nil)
    }
    
    
    class func forgotPassword(target: UIViewController) {
        let alertController = UIAlertController(title: "Forgot Password", message: "No problem, just enter your email to reset your password.", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        let submitAction = UIAlertAction(title: "Submit", style: .Default) { (action) -> Void in
            let emailTextField = alertController.textFields![0]
            if emailTextField.text != "" {
                if let email = emailTextField.text {
                    FirebaseController.sharedInstance.ref.resetPasswordForUser(email, withCompletionBlock: { (error) -> Void in
                        if error == nil {
                            target.dismissViewControllerAnimated(true, completion: nil)
                        } else {
                            print("Error sending reset password email: \(error.localizedDescription)")
                        }
                    })
                }
            }
        }
        alertController.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.placeholder = "Email"
            textField.keyboardType = .EmailAddress
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(submitAction)
        
        target.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: Settings alerts
    class func changePasswordAlert(target: UIViewController) {
        let alertController = UIAlertController(title: "Password", message: "Enter a new Password", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action: UIAlertAction) -> Void in
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .Default) { (action: UIAlertAction) -> Void in
            
            let emailTextField = alertController.textFields![0]
            let oldPasswordTextField = alertController.textFields![1]
            let newPasswordTextField = alertController.textFields![2]
            let confirmNewPasswordTextField = alertController.textFields![3]
            
            if newPasswordTextField.text == confirmNewPasswordTextField.text {
                FirebaseController.sharedInstance.ref.changePasswordForUser(emailTextField.text, fromOld: oldPasswordTextField.text, toNew: newPasswordTextField.text, withCompletionBlock: { (error) -> Void in
                    if error == nil {
                        print("Password reset email sent successfully")
                    } else {
                        print("Error sending password reset email: \(error)")
                    }
                })
            } else {
                self.passwordsDoNotMatchAlert(target)
            }
            
        }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Email Address"
            textField.keyboardType = .EmailAddress
        }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Old Password"
            textField.secureTextEntry = true
        }
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "New Password"
            textField.secureTextEntry = true
        }
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Confirm Password"
            textField.secureTextEntry = true
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        target.presentViewController(alertController, animated: true, completion: nil)
    }
    
    class func logOutUser(target: UIViewController) {
        let alertController = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .Alert)
        
        let logOutAction = UIAlertAction(title: "Log Out", style: .Destructive) { (action) -> Void in
            
            let ref = FirebaseController.sharedInstance.ref
            FirebaseController.sharedInstance.wipeArraysForNewUser()
            // Logs out user
            ref.unauth()
            // Removes userID from NSUserDefaults so user isn't logged back in
            NSUserDefaults.standardUserDefaults().removeObjectForKey("userID")
            // Unwinds to the categoryTVC which will send logged out user to the loginVC
            target.performSegueWithIdentifier("unwindToCategoryTVCSegue", sender: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        alertController.addAction(logOutAction)
        alertController.addAction(cancelAction)
        
        target.presentViewController(alertController, animated: true, completion: nil)
    }
    
    class func deleteAccountAlert(target: UIViewController) {
        let alertController = UIAlertController(title: "Delete Account", message: "If you are sure you want to delete your account, please enter you email and password", preferredStyle: .Alert)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .Destructive) { (action) -> Void in
            let emailTextField = alertController.textFields![0]
            let passwordTextField = alertController.textFields![1]
            
            if emailTextField != "" && passwordTextField != "" {
                if let currentUser = FirebaseController.sharedInstance.currentUser {
                    FirebaseController.sharedInstance.deleteUserFromFirebase(currentUser, email: emailTextField.text!, password: passwordTextField.text!, completion: { () -> () in
                        // Removes userID from NSUserDefaults so user isn't logged back in
                        NSUserDefaults.standardUserDefaults().removeObjectForKey("userID")
                        // Unwinds to the categoryTVC which will send logged out user to the loginVC
                        target.performSegueWithIdentifier("unwindToCategoryTVCSegue", sender: nil)
                    })
                }
            } else {
                // Add alert asking the user to fill in fields
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Email Address"
            textField.keyboardType = .EmailAddress
        }
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Password"
            textField.secureTextEntry = true
        }
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        target.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // Passwords did not match alert
    class func passwordsDoNotMatchAlert(target: UIViewController) {
        let alertController = UIAlertController(title: "Oops", message: "The passwords you entered do not match", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
            self.changePasswordAlert(target)
        }
        
        alertController.addAction(okAction)
        
        target.presentViewController(alertController, animated: true, completion: nil)
    }
}
