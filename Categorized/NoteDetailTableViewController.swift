//
//  NoteDetailTableViewController.swift
//  Categorized
//
//  Created by Nathan on 2/3/16.
//  Copyright © 2016 FalcOne Development. All rights reserved.
//

import UIKit

class NoteDetailTableViewController: UITableViewController {
    
    var category: Category?
    var note: Note?
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "paper")!)
        
        //        if let unwrappedNote = note {
        //            FirebaseController.sharedInstance.fetchNoteWithNoteID(unwrappedNote.ref!.key, completion: { (note) -> () in
        //                if let updateNote = note {
        //                    self.textView.text = updateNote.bodyText
        //                }
        //            })
        //        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name:UIKeyboardWillHideNotification, object: nil)
    }
    
    //    override func viewWillDisappear(animated: Bool) {
    //        super.viewWillDisappear(true)
    //        if let unwrappedNote = note, let unwrappedCategory = category {
    //            // Only saves the note if the bodyText has changed
    //            if unwrappedNote.bodyText != textView.text {
    //                FirebaseController.sharedInstance.updateNote(textView.text, note: unwrappedNote, category: unwrappedCategory)
    //            }
    //        }
    //    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
//                        bottomConstraint.constant = keyboardSize.height
            //            textView.layoutIfNeeded()
//            tableView.frame.origin.y -= keyboardSize.height
            //            keyboardHeight = keyboardSize.height
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
//                        bottomConstraint.constant = keyboardSize.height
            //            textView.layoutIfNeeded()
//            tableView.frame.origin.y += keyboardSize.height
        }
    }
    
    @IBAction func shareButtonTapped(sender: AnyObject) {
        // TODO: Find out why this crashes
        //        if let unwrappedNote = note {
        //            UIAlertController.displayShareSheet(self, note: unwrappedNote)
        //        }
    }
    
    // MARK: Scroll view and text view delegate
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        resignFirstResponder()
    }
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("textViewCell", forIndexPath: indexPath) as! TextViewTableViewCell
        
        if let note = note, let category = category {
            cell.configureCellWithNoteAndCategory(note, category: category)
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(view.frame.size.height - 100)
    }
}

extension NoteDetailTableViewController {
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        // Theme
        if let theme = defaults.objectForKey("themeNum") {
            if let colorIndex = theme as? Int {
                switch colorIndex {
                case 0:
                    navigationItem.leftBarButtonItem?.tintColor = UIColor.themeOrange()
                    navigationItem.rightBarButtonItem?.tintColor = UIColor.themeOrange()
                    navigationController?.navigationBar.tintColor = UIColor.themeOrange()
                    //                    shareButton.tintColor = UIColor.themeOrange()
                    break
                case 1:
                    navigationItem.leftBarButtonItem?.tintColor = UIColor.themeYellow()
                    navigationItem.rightBarButtonItem?.tintColor = UIColor.themeYellow()
                    navigationController?.navigationBar.tintColor = UIColor.themeYellow()
                    //                    shareButton.tintColor = UIColor.themeYellow()
                    break
                case 2:
                    navigationItem.leftBarButtonItem?.tintColor = UIColor.themeGreen()
                    navigationItem.rightBarButtonItem?.tintColor = UIColor.themeGreen()
                    navigationController?.navigationBar.tintColor = UIColor.themeGreen()
                    //                    shareButton.tintColor = UIColor.themeGreen()
                    break
                case 3:
                    navigationItem.leftBarButtonItem?.tintColor = UIColor.themeBlue()
                    navigationItem.rightBarButtonItem?.tintColor = UIColor.themeBlue()
                    navigationController?.navigationBar.tintColor = UIColor.themeBlue()
                    //                    shareButton.tintColor = UIColor.themeBlue()
                    break
                case 4:
                    navigationItem.leftBarButtonItem?.tintColor = UIColor.themePink()
                    navigationItem.rightBarButtonItem?.tintColor = UIColor.themePink()
                    navigationController?.navigationBar.tintColor = UIColor.themePink()
                    //                    shareButton.tintColor = UIColor.themePink()
                    break
                default:
                    navigationItem.leftBarButtonItem?.tintColor = UIColor.themeYellow()
                    navigationItem.rightBarButtonItem?.tintColor = UIColor.themeYellow()
                    navigationController?.navigationBar.tintColor = UIColor.themeYellow()
                    //                    shareButton.tintColor = UIColor.themeYellow()
                    break
                }
            }
        } else {
            navigationItem.leftBarButtonItem?.tintColor = UIColor.themeYellow()
            navigationItem.rightBarButtonItem?.tintColor = UIColor.themeYellow()
            navigationController?.navigationBar.tintColor = UIColor.themeYellow()
            //            shareButton.tintColor = UIColor.themeYellow()
        }
    }
}
