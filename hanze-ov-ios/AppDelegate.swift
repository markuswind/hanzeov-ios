//
//  AppDelegate.swift
//  hanze-ov-ios
//
//  Created by Markus Wind on 1/10/16.
//  Copyright © 2016 Markus Wind. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let TabBarController = storyboard.instantiateViewControllerWithIdentifier("TabBarController")
        let selectClassViewController = storyboard.instantiateViewControllerWithIdentifier("WelcomeViewController")

        let defaults = NSUserDefaults.standardUserDefaults()
        let savedClassId = defaults.valueForKey("classId")

        if savedClassId != nil {
            window!.rootViewController = TabBarController
        } else {
            window!.rootViewController = selectClassViewController
        }

        return true
    }

    func applicationWillResignActive(application: UIApplication) {

    }

    func applicationDidEnterBackground(application: UIApplication) {

    }

    func applicationWillEnterForeground(application: UIApplication) {

    }

    func applicationDidBecomeActive(application: UIApplication) {

    }

    func applicationWillTerminate(application: UIApplication) {

    }


}

