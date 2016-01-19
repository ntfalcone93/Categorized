//
//  NotesTableViewController.swift
//  Categorized
//
//  Created by Nathan on 1/16/16.
//  Copyright © 2016 FalcOne Development. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {
    
    // IBOutlets
    @IBOutlet weak var noteCount: UIBarButtonItem!
    var category: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        if let unwrappedCategory = category {
            // Fetch notes
            FirebaseController.sharedInstance.fetchCategoriesNotes(unwrappedCategory, completion: { () -> () in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    // Note count
                    if unwrappedCategory.notes.count >= 1 {
                        self.noteCount.title = "\(unwrappedCategory.notes.count) Notes"
                        self.tableView.reloadData()
                    } else {
                        self.noteCount.title = "0 Notes"
                    }
                })
            })
            if unwrappedCategory.notes.count == 0 {
                self.noteCount.title = "0 Notes"
            }
        }
        
        // Note count
        noteCount.enabled = false
        noteCount.tintColor = UIColor.blackColor()
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    // MARK: IBActions
    // Edit button
    @IBAction func editButtonTapped(sender: AnyObject) {
        
    }
    
    // New button
    @IBAction func newButtonTapped(sender: AnyObject) {
        if let unwrappedCategory = category {
            UIAlertController.createNewNote(self, category: unwrappedCategory, completion: { () -> () in
                // TODO: Figure out why none of this is getting called
                // Adds 1 to the note count
                //                self.noteCount.title = "\(unwrappedCategory.notes.count + 1) Notes"
                //                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                //                    self.tableView.reloadData()
                //                })
            })
        }
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toNoteDetailSegue" {
            let noteDetailVC = segue.destinationViewController as! NoteDetailViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                let note = FirebaseController.sharedInstance.notesInCategory[indexPath.row]
                noteDetailVC.note = note
                noteDetailVC.title = note.title
            }
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FirebaseController.sharedInstance.notesInCategory.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("noteCell", forIndexPath: indexPath)
        
        let note = FirebaseController.sharedInstance.notesInCategory[indexPath.row]
        cell.textLabel?.text = note.title
        
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
            if let unwrappedCategory = category {
                // TODO: Find out why the array duplicates here
                let note = FirebaseController.sharedInstance.notesInCategory[indexPath.row]
                FirebaseController.sharedInstance.removeNoteFromCategory(unwrappedCategory, note: note)
                FirebaseController.sharedInstance.notesInCategory.removeAtIndex(indexPath.row)
            }
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
}
