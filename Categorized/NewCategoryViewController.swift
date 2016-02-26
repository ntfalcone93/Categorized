//
//  NewCategoryViewController.swift
//  Categorized
//
//  Created by Nathan on 2/24/16.
//  Copyright © 2016 FalcOne Development. All rights reserved.
//

import UIKit

class NewCategoryViewController: UIViewController {
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var captionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertView.backgroundColor = UIColor(patternImage: UIImage(named: "paper")!)
        alertView.layer.cornerRadius = 8
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func createTapped(sender: AnyObject) {
        if !(titleTextField.text == "") {
            // Save category
        } else {
            if let presentingViewController = presentingViewController {
                UIAlertController.categoryTitleTextFieldEmpty(presentingViewController)
            }
        }
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
}
