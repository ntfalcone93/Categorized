//
//  CategoryNavController.swift
//  Categorized
//
//  Created by Nathan on 1/30/16.
//  Copyright © 2016 FalcOne Development. All rights reserved.
//

import UIKit

class CategoryNavController: UINavigationController {
    
    let defaults = NSUserDefaults.standardUserDefaults()

//    override func viewDidLoad() {
//        super.viewDidLoad()

//        // Font
//        if let fontSizeObject = defaults.objectForKey("fontSize"), let fontStyleObject = defaults.objectForKey("fontStyle") {
//            // Cast objects from Defaults
//            if let fontSize = fontSizeObject as? CGFloat, let fontStyle = fontStyleObject as? String {
//                if let customFont = UIFont(name: fontStyle, size: fontSize) {
//                    // If the chosen font size is bigger than 22 then the size for everything but the textView defaults to 24
//                    if fontSize >= 24 {
//                        if let bigFont = UIFont(name: fontStyle, size: 24) {
//                            UINavigationBar.appearance().titleTextAttributes = [ NSFontAttributeName: bigFont]
//                            UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: bigFont], forState: UIControlState.Normal)
//                            UILabel.appearance().font = bigFont
//                            // Text view keeps the users custom font size
//                            UITextView.appearance().font = customFont
//                        }
//                        // If the chosen font size is smaller than 20 then the size for everything but the textView defaults to 24
//                    } else if fontSize <= 18 {
//                        if let smallerFont = UIFont(name: fontStyle, size: 18) {
//                            UINavigationBar.appearance().titleTextAttributes = [ NSFontAttributeName: smallerFont]
//                            UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: smallerFont], forState: UIControlState.Normal)
//                            UILabel.appearance().font = smallerFont
//                            // Text view keeps the users custom font size
//                            UITextView.appearance().font = customFont
//                        }
//                    } else {
//                        // Else if the font size is 18 - 24 than the font is whatever the user chose
//                        UINavigationBar.appearance().titleTextAttributes = [ NSFontAttributeName: customFont]
//                        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: customFont], forState: UIControlState.Normal)
//                        UILabel.appearance().font = customFont
//                        UITextView.appearance().font = customFont
//                    }
//                    
//                }
//            }
//        }
//        
//    }
//    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        self.toolbar.barTintColor = UIColor(patternImage: UIImage(named: "paper")!)
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
    
}
