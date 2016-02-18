//
//  NoteDetailViewController.swift
//  Categorized
//
//  Created by Nathan on 1/16/16.
//  Copyright © 2016 FalcOne Development. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController, UIScrollViewDelegate, UITextViewDelegate {
    var category: Category?
    var note: Note?
    // IBOutlets
        @IBOutlet weak var textView: UITextView!
    
//    let textView = UITextView()
    let defaults = NSUserDefaults.standardUserDefaults()
    var keyboardHeight: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Backgroung Image
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "paper")!)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        saveNote()
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            textView.frame.size.height -= keyboardSize.height
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            textView.frame.size.height += keyboardSize.height
        }
    }
    
    // MARK: IBActions
    // Share button
    @IBAction func shareButtonTapped(sender: AnyObject) {
        // TODO: Find out why this crashes
        //        if let unwrappedNote = note {
        //            UIAlertController.displayShareSheet(self, note: unwrappedNote)
        //        }
    }
    
    // MARK: Scroll view and text view delegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.dragging == true {
            textView.resignFirstResponder()
        }
        //        textView.frame.size.height = self.view.frame.size.height
        //        textView.frame.size.width = self.view.frame.size.width - 15
    }
        
    // Saves note
    func saveNote() {
        if let unwrappedNote = note, let unwrappedCategory = category {
            // Only saves the note if the bodyText has changed
            if unwrappedNote.bodyText != textView.text {
                FirebaseController.sharedInstance.updateNote(textView.text, note: unwrappedNote, category: unwrappedCategory)
            }
        }
    }
}

extension NoteDetailViewController {
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        // TextView
        view.addSubview(textView)
        textView.font = UIFont(name: "AmericanTypewriter", size: 20)
        textView.frame.size.height = self.view.frame.size.height
        textView.frame.size.width = self.view.frame.size.width - 15
        textView.center = self.view.center
        textView.bounces = true
        textView.alwaysBounceVertical = true
        textView.backgroundColor = UIColor.clearColor()
        
        //
        if let unwrappedNote = note {
            
            // Body text
            FirebaseController.sharedInstance.fetchNoteWithNoteID(unwrappedNote.ref!.key, completion: { (note) -> () in
                if let updateNote = note {
                    self.textView.text = updateNote.bodyText
                }
            })
        }
        
        // Keyboard notifications
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name:UIKeyboardWillHideNotification, object: nil)
        
        // Saving note notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "saveNote", name: "appWillEnterBackground", object: nil)
        
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
