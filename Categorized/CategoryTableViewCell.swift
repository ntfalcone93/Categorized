//
//  CategoryTableViewCell.swift
//  Categorized
//
//  Created by Nathan on 1/19/16.
//  Copyright © 2016 FalcOne Development. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var noteCount: UILabel!
    
    func configureCellWithCategory(category: Category) {
        titleLabel.text = category.title
        if captionLabel.text == "" {
            
        } else {
            captionLabel.text = category.caption
        }
        noteCount.text = ""
        //        noteCount.text = "\(category.notes.count)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
