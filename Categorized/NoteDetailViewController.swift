//
//  NoteDetailViewController.swift
//  Categorized
//
//  Created by Nathan on 1/16/16.
//  Copyright © 2016 FalcOne Development. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController, UIScrollViewDelegate, UITextViewDelegate {
    
    var note: Note?
    // IBOutlets
    @IBOutlet weak var textView: UITextView!
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
        if let unwrappedNote = note {
            FirebaseController.sharedInstance.updateNote(textView.text, note: unwrappedNote)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: IBActions
    // Share button
    @IBAction func shareButtonTapped(sender: AnyObject) {
        
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
