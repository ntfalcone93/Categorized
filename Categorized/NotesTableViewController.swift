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
    var selectedNote: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        if let unwrappedCategory = category {
            // Fetch notes
            FirebaseController.sharedInstance.fetchCategoriesNotes(unwrappedCategory, completion: { () -> () in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
            })
            // Title
//            navigationController?.navigationBar.topItem?.title = unwrappedCategory.title
            // Note count
            noteCount.title = "\(unwrappedCategory.notes.count)"
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
        
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "" {
            let noteDetailVC = segue.destinationViewController as! NoteDetailViewController
            if let unwrappedNote = selectedNote {
                noteDetailVC.note = unwrappedNote
                noteDetailVC.navigationItem.title = unwrappedNote.title
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let note = FirebaseController.sharedInstance.notesInCategory[indexPath.row]
        selectedNote = note
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
