//
//  PickerViewController.swift
//  Categorized
//
//  Created by Nathan on 1/19/16.
//  Copyright © 2016 FalcOne Development. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController {
    
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var currentFontSize: UIBarButtonItem!
    let fontSizes = [6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toolbar.backgroundColor = UIColor(patternImage: UIImage(named: "paper")!)
        
        // Sets the current index from the font size that is stored in NSUserDefaults
        if let fontSize = defaults.objectForKey("fontSize") {
            if let fontInt = fontSize as? Int {
                let index = getIndexOfFontSizes(fontInt)
                pickerView.selectRow(index, inComponent: 0, animated: true)
                currentFontSize.title = "Current Font Size: \(fontInt)"
            }
        }
        
        currentFontSize.enabled = false
        currentFontSize.tintColor = UIColor.blackColor()
    }
    
    // MARK: IBActions
    @IBAction func doneButtonTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Gets the index of the font in fontsizes
    func getIndexOfFontSizes(fontSize: Int) -> Int {
        var index = 0
        for size in fontSizes {
            if size == fontSize {
                return index
            } else {
                index += 1
            }
        }
        return index
    }
}

extension PickerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fontSizes.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(fontSizes[row])"
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        defaults.setValue(fontSizes[row], forKey: "fontSize")
    }
}

// Extension for theme
extension PickerViewController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        // Theme
        if let theme = defaults.objectForKey("themeNum") {
            if let colorIndex = theme as? Int {
                switch colorIndex {
                case 0:
                    toolbar.tintColor = UIColor.themeOrange()
                    break
                case 1:
                    toolbar.tintColor = UIColor.themeYellow()
                    break
                case 2:
                    toolbar.tintColor = UIColor.themeGreen()
                    break
                case 3:
                    toolbar.tintColor = UIColor.themeBlue()
                    break
                case 4:
                    toolbar.tintColor = UIColor.themePink()
                    break
                default:
                    toolbar.tintColor = UIColor.themeYellow()
                    break
                }
            }
        } else {
            toolbar.tintColor = UIColor.themeYellow()
        }
    }
}
