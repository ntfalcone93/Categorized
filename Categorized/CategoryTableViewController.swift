//
//  CategoryTableViewController.swift
//  Categorized
//
//  Created by Nathan on 1/16/16.
//  Copyright © 2016 FalcOne Development. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    var selectedCategory: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check if user is logged in
        self.checkForUser { () -> () in
            // TESTING
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
    
    // MARK: IBActions
    // Edit button
    @IBAction func editButtonTapped(sender: AnyObject) {
        
    }
    // New button
    @IBAction func newButtonTapped(sender: AnyObject) {
        
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "categoryToNotesSegue" {
            let notesTVC = segue.destinationViewController as! NotesTableViewController
            if let unwrappedCategory = selectedCategory {
                notesTVC.category = unwrappedCategory
                notesTVC.navigationItem.title = unwrappedCategory.title
            }
        }
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
        
        let category = FirebaseController.sharedInstance.usersCategories[indexPath.row]
        cell.textLabel?.text = category.title
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let category = FirebaseController.sharedInstance.usersCategories[indexPath.row]
        selectedCategory = category
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}
