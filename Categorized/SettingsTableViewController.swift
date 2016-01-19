//
//  SettingsTableViewController.swift
//  Categorized
//
//  Created by Nathan on 1/19/16.
//  Copyright © 2016 FalcOne Development. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: IBActions
    @IBAction func doneButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("settingCell", forIndexPath: indexPath)
        
        switch indexPath.row {
        case 0 :
            cell.textLabel?.text = "Change Font Size"
        case 1:
            cell.textLabel?.text = "Terms of Service"
        case 2:
            cell.textLabel?.text = "Change Password"
        case 3:
            cell.textLabel?.text = "Log Out"
        case 4:
            cell.textLabel?.text = "Delete Account"
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.row {
        case 0:
            // Present PickerViewController
            let pickerVC = self.storyboard?.instantiateViewControllerWithIdentifier("pickerVC") as! PickerViewController
            // Makes the PickerViewController show up on top of the current view
            pickerVC.modalPresentationStyle = .OverCurrentContext
            presentViewController(pickerVC, animated: true, completion: nil)
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
            //            UIAlertController.deleteAccountAlert(self)
            break
        default:
            break
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
