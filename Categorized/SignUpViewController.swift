//
//  SignUpViewController.swift
//  Categorized
//
//  Created by Nathan on 1/17/16.
//  Copyright © 2016 FalcOne Development. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: IBActions
    @IBAction func createAccountButtonTapped(sender: AnyObject) {
        if passwordTextField.text == confirmPasswordTextField.text && passwordTextField.text != "" {
            // Code to create accout
            if let email = emailTextField.text, let password = passwordTextField.text {
                FirebaseController.sharedInstance.createUserInFirebase(email, password: password)
                self.performSegueWithIdentifier("unwindFromSignUpSegue", sender: nil)
            }
        } else {
            print("Error occured while signing up user")
        }
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "unwindFromSignUpSegue" {
            let categoryTVC = segue.destinationViewController as! CategoryTableViewController
            categoryTVC.userWasSentToLogin = true
        }
    }
}

extension SignUpViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch (textField.tag){
        case 0:
            self.passwordTextField.becomeFirstResponder()
            break
        case 1:
            self.confirmPasswordTextField.becomeFirstResponder()
            break
        default:
            textField.resignFirstResponder()
            break
        }
        return true
    }
}

