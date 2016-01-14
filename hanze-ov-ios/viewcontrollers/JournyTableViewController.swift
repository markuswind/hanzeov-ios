//
//  JournyTableViewController.swift
//  hanze-ov-ios
//
//  Created by Markus Wind on 1/14/16.
//  Copyright © 2016 Markus Wind. All rights reserved.
//

import Foundation
import UIKit

class JournyTableViewController: UITableViewController {

    override func viewDidLoad() {
        themeTableView()

        tableView.registerNib(UINib(nibName: "JournyOptionCell", bundle: nil), forCellReuseIdentifier: "JournyOptionCell")
        tableView.rowHeight = 80.0
    }

    private func themeTableView() {
        tableView.backgroundColor = UIColor(red: 0.96, green: 0.82, blue: 0.4, alpha: 1)
        tableView.separatorColor = UIColor(red: 0.89, green: 0.48, blue: 0.49, alpha: 1)

        tableView.layer.borderWidth = 0.5
        tableView.layer.cornerRadius = 4.0
        tableView.layer.borderColor = UIColor(red: 0.89, green: 0.48, blue: 0.49, alpha: 1).CGColor
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("JournyOptionCell", forIndexPath: indexPath) as! JournyOptionCell
        let selectedBackgroundView = UIView()

        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor(red: 0.96, green: 0.82, blue: 0.4, alpha: 1.0)
            selectedBackgroundView.backgroundColor = UIColor(red: 0.96, green: 0.75, blue: 0.4, alpha: 0.8)
        } else {
            cell.backgroundColor = UIColor(red: 0.96, green: 0.75, blue: 0.4, alpha: 1.0)
            selectedBackgroundView.backgroundColor = UIColor(red: 0.96, green: 0.82, blue: 0.4, alpha: 0.8)
        }

        cell.selectedBackgroundView = selectedBackgroundView

        return cell
    }
    
}