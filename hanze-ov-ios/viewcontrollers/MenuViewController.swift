//
//  MenuViewController.swift
//  hanze-ov-ios
//
//  Created by Markus Wind on 1/27/16.
//  Copyright © 2016 Markus Wind. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {

    let menuItems: [String] = [
        "Zoek bushaltes",
        "Klantenservice",
        "Uw mening",
        "Over deze app",
        "Voorwaarden"
    ]

    override func viewDidLoad() {
        navigationController?.navigationBar.topItem?.title = "Info & help"

        tableView.registerNib(UINib(nibName: "MenuItemCell", bundle: nil), forCellReuseIdentifier: "MenuItemCell")
        tableView.rowHeight = 44.0
        tableView.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1)

        tableView.reloadData()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuItemCell", forIndexPath: indexPath) as! MenuItemCell
        cell.nameLabel.text = menuItems[indexPath.row]

        return UITableViewCell()
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }

}

class MenuItemCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!

}