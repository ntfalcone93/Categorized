//
//  CategoryTableViewController.swift
//  Categorized
//
//  Created by Nathan on 1/16/16.
//  Copyright © 2016 FalcOne Development. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    var userWasSentToLogin: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check if user is logged in
        self.checkForUser { () -> () in
            // Fetch the users categories
            if let unwrappedUser = FirebaseController.sharedInstance.currentUser {
                FirebaseController.sharedInstance.fetchUsersCategories(unwrappedUser, completion: { () -> () in
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.tableView.reloadData()
                    })
                })
            }
        }
        
        // Allows editing
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        // Added this because if the user is sent to the loginVC the view does not reload
        if userWasSentToLogin == true {
            // Check if user is logged in
            self.checkForUser { () -> () in
                // Fetch the users categories
                if let unwrappedUser = FirebaseController.sharedInstance.currentUser {
                    FirebaseController.sharedInstance.fetchUsersCategories(unwrappedUser, completion: { () -> () in
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.tableView.reloadData()
                        })
                    })
                }
            }
        }
    }
    
    // MARK: IBActions
    // Edit button
    @IBAction func editButtonTapped(sender: AnyObject) {
        
    }
    
    // New button
    @IBAction func newButtonTapped(sender: AnyObject) {
        UIAlertController.createNewCategory(self) { () -> () in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        }
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "categoryToNotesSegue" {
            let notesTVC = segue.destinationViewController as! NotesTableViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                let category = FirebaseController.sharedInstance.usersCategories[indexPath.row]
                notesTVC.category = category
                notesTVC.navigationItem.title = category.title
            }
        }
    }
    
    // Unwinds from the settingsTVC
    @IBAction func unwindFromSettingsSegue(unwindSegue: UIStoryboardSegue) {
        // No additional code needed for this the function properly
    }
    
    // Unwinds from the loginVC
    @IBAction func unwindFromLoginSegue(unwindSegue: UIStoryboardSegue) {
        // No additional code needed for this the function properly
    }
    
    // Checks to see if a user is logged in still and fetches that user
    func checkForUser(completion:() -> ()){
        FirebaseController.sharedInstance.fetchCurrentUser({ (authData) -> () in
            if authData == nil {
                self.performSegueWithIdentifier("toLoginViewController", sender: nil)
                completion()
            } else {
                if let auth = authData {
                    FirebaseController.sharedInstance.retrieveCurrentUserWithUserID(auth.uid, completion: { (user) -> () in
                        FirebaseController.sharedInstance.currentUser = user
                        completion()
                    })
                }
            }
        })
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FirebaseController.sharedInstance.usersCategories.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("categoryCell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor(patternImage: UIImage(named: "paper")!)
        let category = FirebaseController.sharedInstance.usersCategories[indexPath.row]
        cell.textLabel?.text = category.title
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            if let unwrappedUser = FirebaseController.sharedInstance.currentUser {
                // TODO: Find out why the array duplicates here
                let category = FirebaseController.sharedInstance.usersCategories[indexPath.row]
                FirebaseController.sharedInstance.removeCategoryFromUsersCategories(category, user: unwrappedUser)
                FirebaseController.sharedInstance.usersCategories.removeAtIndex(indexPath.row)
            }
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
}
