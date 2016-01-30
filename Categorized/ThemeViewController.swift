//
//  ThemeViewController.swift
//  Categorized
//
//  Created by Nathan on 1/20/16.
//  Copyright © 2016 FalcOne Development. All rights reserved.
//

import UIKit

class ThemeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        
        NSNotificationCenter.defaultCenter().postNotificationName("changedTheme", object: nil)
    }
    
    // MARK: IBActions
    @IBAction func doneButtonTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

// MARK: Done button theme
extension ThemeViewController {
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        if let theme = defaults.objectForKey("themeNum") {
            if let colorIndex = theme as? Int {
                switch colorIndex {
                case 0:
                    doneButton.tintColor = UIColor.themeOrange()
                    break
                case 1:
                    doneButton.tintColor = UIColor.themeYellow()
                    break
                case 2:
                    doneButton.tintColor = UIColor.themeGreen()
                    break
                case 3:
                    doneButton.tintColor = UIColor.themeBlue()
                    break
                case 4:
                    doneButton.tintColor = UIColor.themePink()
                    break
                default:
                    doneButton.tintColor = UIColor.themeYellow()
                    break
                }
            }
        } else {
            doneButton.tintColor = UIColor.themeYellow()
        }

    }
}

// MARK: Collection View methods
extension ThemeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("orangeCell", forIndexPath: indexPath)
            cell.backgroundColor = UIColor.themeOrange()
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("yellowCell", forIndexPath: indexPath)
            cell.backgroundColor = UIColor.themeYellow()
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("greenCell", forIndexPath: indexPath)
            cell.backgroundColor = UIColor.themeGreen()
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("blueCell", forIndexPath: indexPath)
            cell.backgroundColor = UIColor.themeBlue()
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("pinkCell", forIndexPath: indexPath)
            cell.backgroundColor = UIColor.themePink()
            return cell
        default:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("orangeCell", forIndexPath: indexPath)
            cell.backgroundColor = UIColor.themeYellow()
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            defaults.setObject(0, forKey: "themeNum")
            dismissViewControllerAnimated(true, completion: nil)
            break
        case 1:
            defaults.setObject(1, forKey: "themeNum")
            dismissViewControllerAnimated(true, completion: nil)
            break
        case 2:
            defaults.setObject(2, forKey: "themeNum")
            dismissViewControllerAnimated(true, completion: nil)
            break
        case 3:
            defaults.setObject(3, forKey: "themeNum")
            dismissViewControllerAnimated(true, completion: nil)
            break
        case 4:
            defaults.setObject(4, forKey: "themeNum")
            dismissViewControllerAnimated(true, completion: nil)
            break
        default:
            break
        }
    }
    
    // CollectionViewDelegateFlowLayout Methods
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 5 - 0.5, height: collectionView.frame.size.height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0.5, bottom: 0, right: 0.5)
    }
}
