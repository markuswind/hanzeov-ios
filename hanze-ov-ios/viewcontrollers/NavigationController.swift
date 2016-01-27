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
        navigationBar.barTintColor = UIColor(colorCode: "FC9D3D")
        navigationBar.barStyle = .Black
        navigationBar.translucent = false
    }

}