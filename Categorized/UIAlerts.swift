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
    
    // MARK: Alerts for creating categories and notes
    // Alert for creating new category
    class func createNewCategory(target: UIViewController, completion:() -> ()) {
        let alertController = UIAlertController(title: "New Category", message: "Create a new category with a title and caption", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        let createAction = UIAlertAction(title: "Create", style: .Default) { (action) -> Void in
            let titleTextField = alertController.textFields![0]
            let captionTextField = alertController.textFields![1]
            
            if titleTextField.text != "" {
                if let title = titleTextField.text, let caption = captionTextField.text {
                    FirebaseController.sharedInstance.createNewCategory(title, caption: caption)
                    FirebaseController.sharedInstance.usersCategories.removeAll()
                }
            } else {
                self.categoryTitleTextFieldEmpty(target)
            }
        }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Title"
        }
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Caption"
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
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        let createAction = UIAlertAction(title: "Create", style: .Default) { (action) -> Void in
            let titleTextField = alertController.textFields![0]
            
            if titleTextField.text != "" {
                if let title = titleTextField.text {
                    FirebaseController.sharedInstance.createNewNote(title, category: category)
                    FirebaseController.sharedInstance.notesInCategory.removeAll()
                }
            } else {
                self.noteTitleTextFieldEmpty(target, category: category)
            }
        }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Title"
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
}
