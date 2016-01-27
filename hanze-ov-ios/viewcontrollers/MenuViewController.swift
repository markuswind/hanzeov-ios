//
//  MenuViewController.swift
//  hanze-ov-ios
//
//  Created by Markus Wind on 1/27/16.
//  Copyright © 2016 Markus Wind. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {

    override func viewDidLoad() {
        print("testing")
        navigationController?.navigationBar.topItem?.title = "Info & help"
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        return UITableViewCell()
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }

}