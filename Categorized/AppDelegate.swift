//
//  AppDelegate.swift
//  Categorized
//
//  Created by Nathan on 1/16/16.
//  Copyright © 2016 FalcOne Development. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        UINavigationBar.appearance().barTintColor = UIColor(patternImage: UIImage(named: "paper")!)
        UITableView.appearance().backgroundColor = UIColor(patternImage: UIImage(named: "paper")!)
        UITableViewCell.appearance().backgroundColor = UIColor(patternImage: UIImage(named: "paper")!)
        UITextView.appearance().backgroundColor = UIColor(patternImage: UIImage(named: "paper")!)
        UIPickerView.appearance().backgroundColor = UIColor(patternImage: UIImage(named: "paper")!)
        
        // Theme
//        if let theme = defaults.objectForKey("themeNum") {
//            if let colorIndex = theme as? Int {
//                switch colorIndex {
//                case 0:
//                    UINavigationBar.appearance().tintColor = UIColor.highlighterOrange()
//                    UIBarButtonItem.appearance().tintColor = UIColor.highlighterOrange()
//                    UIButton.appearance().tintColor = UIColor.highlighterOrange()
//                    break
//                case 1:
//                    UINavigationBar.appearance().tintColor = UIColor.highlighterYellow()
//                    UIBarButtonItem.appearance().tintColor = UIColor.highlighterYellow()
//                    UIButton.appearance().tintColor = UIColor.highlighterYellow()
//                    break
//                case 2:
//                    UINavigationBar.appearance().tintColor = UIColor.highlighterGreen()
//                    UIBarButtonItem.appearance().tintColor = UIColor.highlighterGreen()
//                    UIButton.appearance().tintColor = UIColor.highlighterGreen()
//                    break
//                case 3:
//                    UINavigationBar.appearance().tintColor = UIColor.highlighterBlue()
//                    UIBarButtonItem.appearance().tintColor = UIColor.highlighterBlue()
//                    UIButton.appearance().tintColor = UIColor.highlighterBlue()
//                    break
//                case 4:
//                    UINavigationBar.appearance().tintColor = UIColor.highlighterPink()
//                    UIBarButtonItem.appearance().tintColor = UIColor.highlighterPink()
//                    UIButton.appearance().tintColor = UIColor.highlighterPink()
//                    break
//                default:
//                    UINavigationBar.appearance().tintColor = UIColor.highlighterYellow()
//                    UIBarButtonItem.appearance().tintColor = UIColor.highlighterYellow()
//                    UIButton.appearance().tintColor = UIColor.highlighterYellow()
//                    break
//                }
//            }
//        } else {
//            UINavigationBar.appearance().tintColor = UIColor.highlighterOrange()
//            UIBarButtonItem.appearance().tintColor = UIColor.highlighterOrange()
//            UIButton.appearance().tintColor = UIColor.highlighterOrange()
//        }
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

