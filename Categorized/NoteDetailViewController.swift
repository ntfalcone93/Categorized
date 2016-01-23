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
    @IBOutlet weak var shareButton: UIBarButtonItem!
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let unwrappedNote = note {
            
            // Body text
            FirebaseController.sharedInstance.fetchNoteWithNoteID(unwrappedNote.ref!.key, completion: { (note) -> () in
                if let updateNote = note {
                    self.textView.text = updateNote.bodyText
                }
            })
            // Text view font size
            if let font = textView.font {
                if let fontSize = defaults.objectForKey("fontSize") {
                    textView.font = UIFont(name: font.fontName, size: CGFloat(fontSize as! NSNumber))
                } else {
                    textView.font = UIFont(name: font.fontName, size: CGFloat(16))
                }
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        if let unwrappedNote = note, let unwrappedCategory = category {
            FirebaseController.sharedInstance.updateNote(textView.text, note: unwrappedNote, category: unwrappedCategory)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: IBActions
    // Share button
    @IBAction func shareButtonTapped(sender: AnyObject) {
        // TODO: Find out why this crashes
//        if let unwrappedNote = note {
//            UIAlertController.displayShareSheet(self, note: unwrappedNote)
//        }
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: Scroll view and text view delegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        textView.resignFirstResponder()
    }
}

extension NoteDetailViewController {
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
                    shareButton.tintColor = UIColor.themeOrange()
                    break
                case 1:
                    navigationItem.leftBarButtonItem?.tintColor = UIColor.themeYellow()
                    navigationItem.rightBarButtonItem?.tintColor = UIColor.themeYellow()
                    navigationController?.navigationBar.tintColor = UIColor.themeYellow()
                    shareButton.tintColor = UIColor.themeYellow()
                    break
                case 2:
                    navigationItem.leftBarButtonItem?.tintColor = UIColor.themeGreen()
                    navigationItem.rightBarButtonItem?.tintColor = UIColor.themeGreen()
                    navigationController?.navigationBar.tintColor = UIColor.themeGreen()
                    shareButton.tintColor = UIColor.themeGreen()
                    break
                case 3:
                    navigationItem.leftBarButtonItem?.tintColor = UIColor.themeBlue()
                    navigationItem.rightBarButtonItem?.tintColor = UIColor.themeBlue()
                    navigationController?.navigationBar.tintColor = UIColor.themeBlue()
                    shareButton.tintColor = UIColor.themeBlue()
                    break
                case 4:
                    navigationItem.leftBarButtonItem?.tintColor = UIColor.themePink()
                    navigationItem.rightBarButtonItem?.tintColor = UIColor.themePink()
                    navigationController?.navigationBar.tintColor = UIColor.themePink()
                    shareButton.tintColor = UIColor.themePink()
                    break
                default:
                    navigationItem.leftBarButtonItem?.tintColor = UIColor.themeYellow()
                    navigationItem.rightBarButtonItem?.tintColor = UIColor.themeYellow()
                    navigationController?.navigationBar.tintColor = UIColor.themeYellow()
                    shareButton.tintColor = UIColor.themeYellow()
                    break
                }
            }
        } else {
            navigationItem.leftBarButtonItem?.tintColor = UIColor.themeYellow()
            navigationItem.rightBarButtonItem?.tintColor = UIColor.themeYellow()
            navigationController?.navigationBar.tintColor = UIColor.themeYellow()
            shareButton.tintColor = UIColor.themeYellow()
        }
    }
}
