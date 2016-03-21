//
//  SettingsTableViewController.swift
//  Categorized
//
//  Created by Nathan on 1/19/16.
//  Copyright © 2016 FalcOne Development. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateTheme", name: "changedTheme", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateFont", name: "changedFont", object: nil)
        
        // Sets Done buttons font
        let customFont = UIFont(name: ".SFUIText-Light", size: 18)
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: customFont!], forState: .Normal)
    }
    
    // MARK: IBActions
    @IBAction func doneButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    @IBAction func unwindFromFontViewToSettings(unwindSegue: UIStoryboardSegue) {
        if unwindSegue.identifier == "unwindFromFontViewToSettings" {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("settingCell", forIndexPath: indexPath) as! SettingsTableViewCell
        
        //        switch indexPath.row {
        //        case 0 :
        //            cell.settingLabel.text = "Change Font"
        //        case 1:
        //            cell.settingLabel.text = "Change Color Theme"
        //        case 2:
        //            cell.settingLabel.text = "Terms of Service"
        //        case 3:
        //            cell.settingLabel.text = "Change Password"
        //        case 4:
        //            cell.settingLabel.text = "Log Out"
        //        case 5:
        //            cell.settingLabel.text = "Delete Account"
        //        default:
        //            break
        //        }
        
        // TODO: Temp until I fix font
        switch indexPath.row {
        case 0:
            cell.settingLabel.text = "Change Color Theme"
        case 1:
            cell.settingLabel.text = "Terms of Service"
        case 2:
            cell.settingLabel.text = "Change Password"
        case 3:
            cell.settingLabel.text = "Log Out"
        case 4:
            cell.settingLabel.text = "Delete Account"
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //        switch indexPath.row {
        //        case 0:
        //            // Present PickerViewController
        //            let pickerVC = self.storyboard?.instantiateViewControllerWithIdentifier("pickerVC") as! PickerViewController
        //            // Makes the PickerViewController show up on top of the current view
        //            pickerVC.modalPresentationStyle = .OverCurrentContext
        //            presentViewController(pickerVC, animated: true, completion: nil)
        //            break
        //        case 1:
        //            // Present ThemeViewController
        //            let themeVC = self.storyboard?.instantiateViewControllerWithIdentifier("themeVC") as! ThemeViewController
        //            // Makes the ThemeViewController show up on top of the current view
        //            themeVC.modalPresentationStyle = .OverCurrentContext
        //            presentViewController(themeVC, animated: true, completion: nil)
        //            break
        //        case 2:
        //            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //            let termsVC = mainStoryboard.instantiateViewControllerWithIdentifier("termsOfServiceID") as! TermsViewController
        //            self.presentViewController(termsVC, animated: true, completion: nil)
        //            break
        //        case 3:
        //            UIAlertController.changePasswordAlert(self)
        //            break
        //        case 4:
        //            UIAlertController.logOutUser(self)
        //            break
        //        case 5:
        //            //            UIAlertController.deleteAccountAlert(self)
        //            break
        //        default:
        //            break
        //        }
        
        // TODO: Temp until Font is fixed
        switch indexPath.row {
        case 0:
            // Present ThemeViewController
            let themeVC = self.storyboard?.instantiateViewControllerWithIdentifier("themeVC") as! ThemeViewController
            // Makes the ThemeViewController show up on top of the current view
            themeVC.modalPresentationStyle = .OverCurrentContext
            presentViewController(themeVC, animated: true, completion: nil)
            break
        case 1:
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let termsVC = mainStoryboard.instantiateViewControllerWithIdentifier("termsOfServiceID") as! TermsViewController
            self.presentViewController(termsVC, animated: true, completion: nil)
            break
        case 2:
            UIAlertController.changePasswordAlert(self)
            break
        case 3:
            UIAlertController.logOutUser(self)
            break
        case 4:
            UIAlertController.deleteAccountAlert(self)
            break
        default:
            break
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

// Extension for theme
extension SettingsTableViewController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        // Font
        //        if let fontSizeObject = defaults.objectForKey("fontSize"), let fontStyleObject = defaults.objectForKey("fontStyle") {
        //            // Cast objects from Defaults
        //            if let fontSize = fontSizeObject as? CGFloat, let fontStyle = fontStyleObject as? String {
        //                if let customFont = UIFont(name: fontStyle, size: fontSize) {
        //                    // If the chosen font size is bigger than 22 then the size for everything but the textView defaults to 24
        //                    if fontSize >= 24 {
        //                        if let bigFont = UIFont(name: fontStyle, size: 24) {
        //                            UINavigationBar.appearance().titleTextAttributes = [ NSFontAttributeName: bigFont]
        //                            UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: bigFont], forState: UIControlState.Normal)
        //                            UILabel.appearance().font = bigFont
        //                            // Text view keeps the users custom font size
        //                            UITextView.appearance().font = customFont
        //                        }
        //                        // If the chosen font size is smaller than 20 then the size for everything but the textView defaults to 24
        //                    } else if fontSize <= 18 {
        //                        if let smallerFont = UIFont(name: fontStyle, size: 18) {
        //                            UINavigationBar.appearance().titleTextAttributes = [ NSFontAttributeName: smallerFont]
        //                            UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: smallerFont], forState: UIControlState.Normal)
        //                            UILabel.appearance().font = smallerFont
        //                            // Text view keeps the users custom font size
        //                            UITextView.appearance().font = customFont
        //                        }
        //                    } else {
        //                        // Else if the font size is 18 - 24 than the font is whatever the user chose
        //                        UINavigationBar.appearance().titleTextAttributes = [ NSFontAttributeName: customFont]
        //                        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: customFont], forState: UIControlState.Normal)
        //                        UILabel.appearance().font = customFont
        //                        UITextView.appearance().font = customFont
        //                    }
        //
        //                }
        //            }
        //        }
    }
    
    func updateFont() {
        // Font
        if let fontSizeObject = defaults.objectForKey("fontSize"), let fontStyleObject = defaults.objectForKey("fontStyle") {
            // Cast objects from Defaults
            if let fontSize = fontSizeObject as? CGFloat, let fontStyle = fontStyleObject as? String {
                if let customFont = UIFont(name: fontStyle, size: fontSize) {
                    // If the chosen font size is bigger than 22 then the size for everything but the textView defaults to 24
                    if fontSize >= 24 {
                        if let bigFont = UIFont(name: fontStyle, size: 24) {
                            UINavigationBar.appearance().titleTextAttributes = [ NSFontAttributeName: bigFont]
                            UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: bigFont], forState: UIControlState.Normal)
                            UILabel.appearance().font = bigFont
                            // Text view keeps the users custom font size
                            UITextView.appearance().font = customFont
                        }
                        // If the chosen font size is smaller than 20 then the size for everything but the textView defaults to 24
                    } else if fontSize <= 18 {
                        if let smallerFont = UIFont(name: fontStyle, size: 18) {
                            UINavigationBar.appearance().titleTextAttributes = [ NSFontAttributeName: smallerFont]
                            UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: smallerFont], forState: UIControlState.Normal)
                            UILabel.appearance().font = smallerFont
                            // Text view keeps the users custom font size
                            UITextView.appearance().font = customFont
                        }
                    } else {
                        // Else if the font size is 18 - 24 than the font is whatever the user chose
                        UINavigationBar.appearance().titleTextAttributes = [ NSFontAttributeName: customFont]
                        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: customFont], forState: UIControlState.Normal)
                        UILabel.appearance().font = customFont
                        UITextView.appearance().font = customFont
                    }
                    
                }
            }
        }
    }
}
