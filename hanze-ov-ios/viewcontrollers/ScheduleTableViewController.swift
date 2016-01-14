//
//  ScheduleTableViewController.swift
//  hanze-ov-ios
//
//  Created by Markus Wind on 1/14/16.
//  Copyright © 2016 Markus Wind. All rights reserved.
//

import Foundation
import UIKit

class ScheduleTableViewController: UITableViewController {

    override func viewDidLoad() {
        themeTableView()

        tableView.registerNib(UINib(nibName: "ScheduleOptionCell", bundle: nil), forCellReuseIdentifier: "ScheduleOptionCell")
        tableView.rowHeight = 70.0
    }

    private func themeTableView() {
        tableView.backgroundColor = UIColor(red:0.96, green:0.82, blue:0.4, alpha:1)
        tableView.separatorColor = UIColor(red: 0.89, green: 0.48, blue:0.49, alpha:1)

        tableView.layer.borderWidth = 0.5
        tableView.layer.cornerRadius = 4.0
        tableView.layer.borderColor = UIColor(red:0.89, green:0.48, blue:0.49, alpha:1).CGColor
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ScheduleOptionCell", forIndexPath: indexPath) as! ScheduleOptionCell

        return cell
    }

}

class ScheduleOptionCell: UITableViewCell {

    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!

    override func awakeFromNib() {
        let selectedBackgroundColorView = UIView()
        selectedBackgroundColorView.backgroundColor = UIColor(red:0.96, green:0.82, blue:0.4, alpha:0.8)

        selectedBackgroundView = selectedBackgroundColorView
        backgroundColor = UIColor(red:0.97, green:0.77, blue:0.36, alpha:1)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

}