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
                dismissViewControllerAnimated(true, completion: nil)
            }
        } else {
            print("Error occured while signing up user")
        }
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
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

