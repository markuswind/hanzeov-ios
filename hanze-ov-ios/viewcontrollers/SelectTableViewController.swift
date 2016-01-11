//
//  SelectTableViewController.swift
//  hanze-ov-ios
//
//  Created by Markus Wind on 11/01/16.
//  Copyright © 2016 Markus Wind. All rights reserved.
//

import UIKit

class SelectTableViewController: UITableViewController {

    var names = ["Apple", "Apricot", "Banana", "Blueberry", "Cantaloupe", "Cherry" ]

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "InstituteOptionCell")
        let cell = tableView.dequeueReusableCellWithIdentifier("InstituteOptionCell", forIndexPath: indexPath) as UITableViewCell

        return cell
    }
}

class InstituteOptionCell: UITableViewCell {

    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!

}