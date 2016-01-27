//
//  TabBarController.swift
//  hanze-ov-ios
//
//  Created by Markus Wind on 1/19/16.
//  Copyright © 2016 Markus Wind. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        tabBar.barTintColor = UIColor.whiteColor()
        tabBar.tintColor = UIColor.orangeColor()

        for item in tabBar.items! {
            let unselectedItem: NSDictionary = [NSForegroundColorAttributeName: UIColor.grayColor()]
            let selectedItem: NSDictionary = [NSForegroundColorAttributeName: UIColor.orangeColor()]

            item.setTitleTextAttributes(unselectedItem as? [String : AnyObject], forState: .Normal)
            item.setTitleTextAttributes(selectedItem as? [String : AnyObject], forState: .Selected)
        }
    }

}