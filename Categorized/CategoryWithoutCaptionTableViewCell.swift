//
//  CategoryWithoutCaptionTableViewCell.swift
//  Categorized
//
//  Created by Nathan on 2/11/16.
//  Copyright © 2016 FalcOne Development. All rights reserved.
//

import UIKit

class CategoryWithoutCaptionTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noteCount: UILabel!
    
    
    func configureCellWithCategory(category: Category) {
        titleLabel.text = category.title
        noteCount.text = ""
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
