//
//  LoginViewController.swift
//  Categorized
//
//  Created by Nathan on 1/17/16.
//  Copyright © 2016 FalcOne Development. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: IBActions
    @IBAction func loginButtonTapped(sender: AnyObject) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            FirebaseController.sharedInstance.ref.authUser(email, password: password, withCompletionBlock: { (error, auth) -> Void in
                if auth != nil {
                    FirebaseController.sharedInstance.retrieveCurrentUserWithUserID(auth.uid, completion: { (user) -> () in
                        if user != nil {
                            self.defaults.setObject(auth.uid, forKey: "userID")
                            self.performSegueWithIdentifier("unwindFromLoginToCategoryTVC", sender: nil)
                        }
                    })
                } else if error.localizedDescription == "NETWORK_ERROR" {
                    UIAlertController.connectionErrorAlert(self)
                    print("Error while logging user in: \(error.localizedDescription)")
                } else {
                    UIAlertController.invalidLoginAlert(self)
                    print("Error while logging user in: \(error.localizedDescription)")
                }
            })
        }
    }
    
    @IBAction func forgotPasswordButtonTapped(sender: AnyObject) {
        UIAlertController.forgotPassword(self)
    }
    
    // MARK: - Navigation
    override func unwindForSegue(unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "unwindFromLoginToCategoryTVC" {
            let categoryTVC = segue.destinationViewController as! CategoryTableViewController
            categoryTVC.userWasSentToLogin = true
        }
    }
}

extension LoginViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.tag == 0 {
            self.passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}

