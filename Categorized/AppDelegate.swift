//
//  AppDelegate.swift
//  Categorized
//
//  Created by Nathan on 1/16/16.
//  Copyright © 2016 FalcOne Development. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override init() {
        super.init()
        // Persists data
        Firebase.defaultConfig().persistenceEnabled = true
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        // Background Image
        UINavigationBar.appearance().barTintColor = UIColor(patternImage: UIImage(named: "yellowNavTexture")!)
        UINavigationBar.appearance().tintColor = .blackColor()
        UIToolbar.appearance().tintColor = .blackColor()
        UITableView.appearance().backgroundColor = UIColor(patternImage: UIImage(named: "paper")!)
        UITableViewCell.appearance().backgroundColor = UIColor(patternImage: UIImage(named: "paper")!)
        UIPickerView.appearance().backgroundColor = UIColor(patternImage: UIImage(named: "paper")!)
        
        // Font
        UILabel.appearance().font = UIFont(name: ".SFUIRounded-Medium", size: 18)
        let customFont = UIFont(name: ".SFUIDisplay-Medium", size: 18)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: customFont!], forState: UIControlState.Normal)
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: customFont!]
        UITextView.appearance().font = UIFont(name: ".SFUIDisplay-Medium", size: 18)
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        NSNotificationCenter.defaultCenter().postNotificationName("appWillEnterBackground", object: nil)
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

