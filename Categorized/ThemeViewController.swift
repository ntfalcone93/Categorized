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
    @IBOutlet weak var toolbar: UIToolbar!
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if let theme = defaults.objectForKey("themeNum") {
            if let index = theme as? Int {
                let indexPath = getIndexOfTheme(index)
                collectionView.selectItemAtIndexPath(indexPath, animated: true, scrollPosition: .None)
            }
        }
    }
    
    func getIndexOfTheme(index: Int) -> NSIndexPath {
        switch index {
        case 0:
            return NSIndexPath(index: 0)
        case 1:
            return NSIndexPath(index: 1)
        case 2:
            return NSIndexPath(index: 2)
        case 3:
            return NSIndexPath(index: 3)
        case 4:
            return NSIndexPath(index: 4)
        default:
            return NSIndexPath(index: 0)
        }
    }
    
    // MARK: IBActions
    @IBAction func doneButtonTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

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
            break
        case 1:
            defaults.setObject(1, forKey: "themeNum")
            break
        case 2:
            defaults.setObject(2, forKey: "themeNum")
            break
        case 3:
            defaults.setObject(3, forKey: "themeNum")
            break
        case 4:
            defaults.setObject(4, forKey: "themeNum")
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
