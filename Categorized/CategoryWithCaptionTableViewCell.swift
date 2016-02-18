//
//  CategoryWithCaptionTableViewCell.swift
//  Categorized
//
//  Created by Nathan on 2/11/16.
//  Copyright © 2016 FalcOne Development. All rights reserved.
//

import UIKit

class CategoryWithCaptionTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var noteCountLabel: UILabel!
    
    
    func configureCellWithCategory(category: Category) {
        titleLabel.text = category.title
        captionLabel.text = category.caption
        noteCountLabel.text = ""
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
