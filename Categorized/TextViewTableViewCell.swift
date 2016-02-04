//
//  TextViewTableViewCell.swift
//  Categorized
//
//  Created by Nathan on 2/3/16.
//  Copyright © 2016 FalcOne Development. All rights reserved.
//

import UIKit

class TextViewTableViewCell: UITableViewCell {

    @IBOutlet weak var textView: UITextView!
    
    var note: Note?
    var category: Category?
    
    func configureCellWithNoteAndCategory(note: Note, category: Category) {
        textView.text = note.bodyText
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor(patternImage: UIImage(named: "paper")!)
    }
}
