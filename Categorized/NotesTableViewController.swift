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
            } else {
                let count = unwrappedCategory.notes.count
                self.noteCount.title = "\(count) Notes"
            }
        }
        
        // Theme
        if let theme = defaults.objectForKey("themeNum") {
            if let colorIndex = theme as? Int {
                switch colorIndex {
                case 0:
                    navigationItem.leftBarButtonItem?.tintColor = UIColor.themeOrange()
                    navigationItem.rightBarButtonItem?.tintColor = UIColor.themeOrange()
                    navigationController?.navigationBar.tintColor = UIColor.themeOrange()
                    newNoteButton.tintColor = UIColor.themeOrange()
                    break
                case 1:
                    navigationItem.leftBarButtonItem?.tintColor = UIColor.themeYellow()
                    navigationItem.rightBarButtonItem?.tintColor = UIColor.themeYellow()
                    navigationController?.navigationBar.tintColor = UIColor.themeYellow()
                    newNoteButton.tintColor = UIColor.themeYellow()
                    break
                case 2:
                    navigationItem.leftBarButtonItem?.tintColor = UIColor.themeGreen()
                    navigationItem.rightBarButtonItem?.tintColor = UIColor.themeGreen()
                    navigationController?.navigationBar.tintColor = UIColor.themeGreen()
                    newNoteButton.tintColor = UIColor.themeGreen()
                    break
                case 3:
                    navigationItem.leftBarButtonItem?.tintColor = UIColor.themeBlue()
                    navigationItem.rightBarButtonItem?.tintColor = UIColor.themeBlue()
                    navigationController?.navigationBar.tintColor = UIColor.themeBlue()
                    newNoteButton.tintColor = UIColor.themeBlue()
                    break
                case 4:
                    navigationItem.leftBarButtonItem?.tintColor = UIColor.themePink()
                    navigationItem.rightBarButtonItem?.tintColor = UIColor.themePink()
                    navigationController?.navigationBar.tintColor = UIColor.themePink()
                    newNoteButton.tintColor = UIColor.themePink()
                    break
                default:
                    navigationItem.leftBarButtonItem?.tintColor = UIColor.themeYellow()
                    navigationItem.rightBarButtonItem?.tintColor = UIColor.themeYellow()
                    navigationController?.navigationBar.tintColor = UIColor.themeYellow()
                    newNoteButton.tintColor = UIColor.themeYellow()
                    break
                }
            }
        } else {
            navigationItem.leftBarButtonItem?.tintColor = UIColor.themeYellow()
            navigationItem.rightBarButtonItem?.tintColor = UIColor.themeYellow()
            navigationController?.navigationBar.tintColor = UIColor.themeYellow()
            newNoteButton.tintColor = UIColor.themeYellow()
        }
    }
}
