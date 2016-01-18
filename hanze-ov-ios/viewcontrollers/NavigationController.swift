//
//  NavigationController.swift
//  hanze-ov-ios
//
//  Created by Markus Wind on 1/18/16.
//  Copyright © 2016 Markus Wind. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        styleNavigationBar()
    }

    private func styleNavigationBar() {
        navigationBar.barTintColor = UIColor(red:0.97, green:0.77, blue:0.36, alpha:1)

        navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.redColor(),
        ]
    }

}