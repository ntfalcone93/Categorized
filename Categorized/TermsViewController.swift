//
//  TermsViewController.swift
//  Categorized
//
//  Created by Nathan on 1/17/16.
//  Copyright © 2016 FalcOne Development. All rights reserved.
//

import UIKit

class TermsViewController: UIViewController {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "paper")!)
        
        // Theme
        if let theme = defaults.objectForKey("themeNum") {
            if let colorIndex = theme as? Int {
                switch colorIndex {
                case 0:
                    doneButton.tintColor = UIColor.themeOrange()
                    break
                case 1:
                    doneButton.tintColor = UIColor.themeYellow()
                    break
                case 2:
                    doneButton.tintColor = UIColor.themeGreen()
                    break
                case 3:
                    doneButton.tintColor = UIColor.themeBlue()
                    break
                case 4:
                    doneButton.tintColor = UIColor.themePink()
                    break
                default:
                    doneButton.tintColor = UIColor.themeYellow()
                    break
                }
            }
        } else {
            doneButton.tintColor = UIColor.themeYellow()
        }
    }
    
    // Starts text view at top
    override func viewDidLayoutSubviews() {
        textView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    // IBActions
    @IBAction func doneButtonTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
