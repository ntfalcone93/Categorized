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
    let fontSizes = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
    let fontStyles = ["American Typewriter", "Arial", "Avenir", "Courier", "Georgia", "Helvetica", "San Francisco", "Times New Roman", "Verdana"]
    
    var selectedFontStyle = ""
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toolbar.backgroundColor = UIColor(patternImage: UIImage(named: "paper")!)
        
        // Sets the current index from the font size that is stored in NSUserDefaults
        if let fontStyle = defaults.objectForKey("fontStyle"), let fontSize = defaults.objectForKey("fontSize") {
            if let fontStyleString = fontStyle as? String, let fontInt = fontSize as? Int {
                let indexForStyle = getIndexOfFontStyle(fontStyleString)
                let indexForSize = getIndexOfFontSizes(fontInt)
                pickerView.selectRow(indexForStyle, inComponent: 0, animated: true)
                pickerView.selectRow(indexForSize, inComponent: 1, animated: true)
                currentFontSize.title = "Current Style: \(fontStyleString) - \(fontInt)"
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
    
    // Gets the index of the font in font style
    func getIndexOfFontStyle(fontStyle: String) -> Int {
        var index = 0
        for style in fontStyles {
            if style == fontStyle {
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
        switch component {
        case 0:
            return fontStyles.count
        case 1:
            return fontSizes.count
        default:
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(fontStyles[row])"
        case 1:
            return "\(fontSizes[row])"
        default:
            return ""
        }
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        switch component {
        case 0:
            switch row {
            case 0:
                let label = UILabel()
                label.textColor = UIColor.blackColor()
                label.text = "American Typewriter"
                label.textAlignment = NSTextAlignment.Center
                label.font = UIFont(name: "AmericanTypewriter", size: 24)
                return label
            case 1:
                let label = UILabel()
                label.textColor = UIColor.blackColor()
                label.text = "Arial"
                label.textAlignment = NSTextAlignment.Center
                label.font = UIFont(name: "Arial", size: 24)
                return label
            case 2:
                let label = UILabel()
                label.textColor = UIColor.blackColor()
                label.text = "Avenir"
                label.textAlignment = NSTextAlignment.Center
                label.font = UIFont(name: "Avenir", size: 24)
                return label
            case 3:
                let label = UILabel()
                label.textColor = UIColor.blackColor()
                label.text = "Courier"
                label.textAlignment = NSTextAlignment.Center
                label.font = UIFont(name: "Courier", size: 24)
                return label
            case 4:
                let label = UILabel()
                label.textColor = UIColor.blackColor()
                label.text = "Georgia"
                label.textAlignment = NSTextAlignment.Center
                label.font = UIFont(name: "Georgia", size: 24)
                return label
            case 5:
                let label = UILabel()
                label.textColor = UIColor.blackColor()
                label.text = "Helvetica"
                label.textAlignment = NSTextAlignment.Center
                label.font = UIFont(name: "Helvetica", size: 24)
                return label
            case 6:
                let label = UILabel()
                label.textColor = UIColor.blackColor()
                label.text = "San Francisco"
                label.textAlignment = NSTextAlignment.Center
                label.font = UIFont(name: "SanFranciscoText", size: 24)
                return label
            case 7:
                let label = UILabel()
                label.textColor = UIColor.blackColor()
                label.text = "Times New Roman"
                label.textAlignment = NSTextAlignment.Center
                label.font = UIFont(name: "TimesNewRomanPSMT", size: 24)
                return label
            case 8:
                let label = UILabel()
                label.textColor = UIColor.blackColor()
                label.text = "Verdana"
                label.textAlignment = NSTextAlignment.Center
                label.font = UIFont(name: "Verdana", size: 24)
                return label
            default:
                return UIView()
            }
        case 1:
            switch row {
            case 0:
                let label = UILabel()
                label.textColor = UIColor.blackColor()
                label.text = "12"
                label.textAlignment = NSTextAlignment.Center
                label.font = UIFont(name: "Helvetica", size: 12)
                return label
            case 1:
                let label = UILabel()
                label.textColor = UIColor.blackColor()
                label.text = "14"
                label.textAlignment = NSTextAlignment.Center
                label.font = UIFont(name: "Helvetica", size: 14)
                return label
            case 2:
                let label = UILabel()
                label.textColor = UIColor.blackColor()
                label.text = "16"
                label.textAlignment = NSTextAlignment.Center
                label.font = UIFont(name: "Helvetica", size: 16)
                return label
            case 3:
                let label = UILabel()
                label.textColor = UIColor.blackColor()
                label.text = "18"
                label.textAlignment = NSTextAlignment.Center
                label.font = UIFont(name: "Helvetica", size: 18)
                return label
            case 4:
                let label = UILabel()
                label.textColor = UIColor.blackColor()
                label.text = "20"
                label.textAlignment = NSTextAlignment.Center
                label.font = UIFont(name: "Helvetica", size: 20)
                return label
            case 5:
                let label = UILabel()
                label.textColor = UIColor.blackColor()
                label.text = "22"
                label.textAlignment = NSTextAlignment.Center
                label.font = UIFont(name: "Helvetica", size: 22)
                return label
            case 6:
                let label = UILabel()
                label.textColor = UIColor.blackColor()
                label.text = "24"
                label.textAlignment = NSTextAlignment.Center
                label.font = UIFont(name: "Helvetica", size: 24)
                return label
            case 7:
                let label = UILabel()
                label.textColor = UIColor.blackColor()
                label.text = "26"
                label.textAlignment = NSTextAlignment.Center
                label.font = UIFont(name: "Helvetica", size: 26)
                return label
            case 8:
                let label = UILabel()
                label.textColor = UIColor.blackColor()
                label.text = "28"
                label.textAlignment = NSTextAlignment.Center
                label.font = UIFont(name: "Helvetica", size: 28)
                return label
            case 9:
                let label = UILabel()
                label.textColor = UIColor.blackColor()
                label.text = "30"
                label.textAlignment = NSTextAlignment.Center
                label.font = UIFont(name: "Helvetica", size: 30)
                return label
            case 10:
                let label = UILabel()
                label.textColor = UIColor.blackColor()
                label.text = "32"
                label.textAlignment = NSTextAlignment.Center
                label.font = UIFont(name: "Helvetica", size: 32)
                return label
            case 11:
                let label = UILabel()
                label.textColor = UIColor.blackColor()
                label.text = "34"
                label.textAlignment = NSTextAlignment.Center
                label.font = UIFont(name: "Helvetica", size: 34)
                return label
            case 12:
                let label = UILabel()
                label.textColor = UIColor.blackColor()
                label.text = "36"
                label.textAlignment = NSTextAlignment.Center
                label.font = UIFont(name: "Helvetica", size: 36)
                return label
            default:
                return UILabel()
            }
        default:
            return UIView()
        }
    }
    
    //    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    //        <#code#>
    //    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component == 0 {
            return 300
        } else {
            return 50
        }
    }
    
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            defaults.setValue(fontStyles[row], forKey: "fontStyle")
        case 1:
            defaults.setValue(fontSizes[row], forKey: "fontSize")
        default:
            break
        }
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
