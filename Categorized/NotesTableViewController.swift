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
    @IBOutlet weak var newNoteButton: UIBarButtonItem!
    @IBOutlet weak var noteCount: UIBarButtonItem!
    var category: Category?
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                let count = FirebaseController.sharedInstance.notesInCategory.count
                self.noteCount.title = "\(count) Notes"
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
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
                let backItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
                navigationItem.backBarButtonItem = backItem
                if let unwrappedCategory = self.category {
                    noteDetailVC.category = unwrappedCategory
                }
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
        let cell = tableView.dequeueReusableCellWithIdentifier("noteCell") as! NotesTableViewCell
        
        let note = FirebaseController.sharedInstance.notesInCategory[indexPath.row]
        cell.notesLabel.text = note.title
        
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
                FirebaseController.sharedInstance.deleteNote(note, category: unwrappedCategory)
                FirebaseController.sharedInstance.notesInCategory.removeAtIndex(indexPath.row)
                let count = FirebaseController.sharedInstance.notesInCategory.count
                self.noteCount.title = "\(count) Notes"
            }
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
}

extension NotesTableViewController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        
        if let unwrappedCategory = category {
            // Fetch notes
            FirebaseController.sharedInstance.fetchCategoriesNotes(unwrappedCategory, completion: { () -> () in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                    let count = FirebaseController.sharedInstance.notesInCategory.count
                    self.noteCount.title = "\(count) Notes"
                })
            })
            if unwrappedCategory.notes.count == 0 {
                self.noteCount.title = "0 Notes"
            } else {
                let count = FirebaseController.sharedInstance.notesInCategory.count
                self.noteCount.title = "\(count) Notes"
            }
        }
    }
}
