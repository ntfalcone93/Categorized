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
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var signUpLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "paper")!)
        
        // Keeps the labels and buttons the correct font and size
        signUpLabel.font = UIFont(name: "AmericanTypewriter", size: 40)
        emailTextField.font = UIFont(name: "AmericanTypewriter", size: 14)
        passwordTextField.font = UIFont(name: "AmericanTypewriter", size: 14)
        confirmPasswordTextField.font = UIFont(name: "AmericanTypewriter", size: 14)
        
        
        // Create Account button
        createAccountButton.titleLabel?.font = UIFont(name: "AmericanTypewriter", size: 24)
        createAccountButton.layer.cornerRadius = 22
        createAccountButton.layer.borderColor = UIColor.clearColor().CGColor
        createAccountButton.layer.borderWidth = 2
        createAccountButton.layer.shadowColor = UIColor.grayColor().CGColor
        createAccountButton.layer.shadowOffset = CGSizeMake(1, 2)
        createAccountButton.layer.shadowRadius = 1.0
        createAccountButton.layer.shadowOpacity = 1.0
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
                FirebaseController.sharedInstance.createUserInFirebase(email, password: password, completion: { () -> () in
                    self.performSegueWithIdentifier("unwindFromSignUpSegue", sender: nil)
                })
            }
        } else {
            print("Error occured while signing up user")
        }
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Tap gesture resigns keyboard
    @IBAction func resignKeyboardGestureTapped(sender: AnyObject) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
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

