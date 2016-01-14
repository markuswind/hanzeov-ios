//
//  ScheduleTableViewController.swift
//  hanze-ov-ios
//
//  Created by Markus Wind on 1/14/16.
//  Copyright © 2016 Markus Wind. All rights reserved.
//

import Foundation
import UIKit

enum ScheduleSelectState {
    case Schedule
    case Journy
}

class ScheduleTableViewController: UITableViewController {

    var selectState: ScheduleSelectState = .Schedule

    override func viewDidLoad() {
        themeTableView()

        tableView.registerNib(UINib(nibName: "ScheduleOptionCell", bundle: nil), forCellReuseIdentifier: "ScheduleOptionCell")
        tableView.rowHeight = 70.0
    }

    private func themeTableView() {
        tableView.backgroundColor = UIColor(red: 0.96, green: 0.82, blue: 0.4, alpha: 1)
        tableView.separatorColor = UIColor(red: 0.89, green: 0.48, blue: 0.49, alpha: 1)

        tableView.layer.borderWidth = 0.5
        tableView.layer.cornerRadius = 4.0
        tableView.layer.borderColor = UIColor(red: 0.89, green: 0.48, blue: 0.49, alpha: 1).CGColor
    }

    private func setupTableView() {
        switch selectState {
        case .Schedule:
            setupScheduleSelection()

            break
        case .Journy:
            setupJournySelection()

            break
        }
    }

    private func setupScheduleSelection() {
        tableView.registerNib(UINib(nibName: "ScheduleOptionCell", bundle: nil), forCellReuseIdentifier: "ScheduleOptionCell")
        tableView.rowHeight = 70.0
    }

    private func setupJournySelection() {
        tableView.registerNib(UINib(nibName: "JournyOptionCell", bundle: nil), forCellReuseIdentifier: "JournyOptionCell")
        tableView.rowHeight = 80.0

        reloadTableData()
    }

    private func reloadTableData() {
        UIView.transitionWithView(tableView, duration:0.65, options:.TransitionCrossDissolve,
            animations: { () -> Void in
                self.tableView.reloadData()
            },
        completion: nil)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectState {
        case .Schedule:
            return 10
        case .Journy:
            return 5
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell

        switch selectState {
        case .Schedule:
            cell = tableView.dequeueReusableCellWithIdentifier("ScheduleOptionCell", forIndexPath: indexPath) as! ScheduleOptionCell
            break
        case .Journy:
            cell = tableView.dequeueReusableCellWithIdentifier("JournyOptionCell", forIndexPath: indexPath) as! JournyOptionCell
            break
        }

        return cell
    }

    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        switch selectState {
        case .Schedule:
            selectState = .Journy
            
            setupTableView()

            break
        case .Journy:
            break
        }

        return indexPath
    }

}

class ScheduleOptionCell: UITableViewCell {

    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!

    override func awakeFromNib() {
        let selectedBackgroundColorView = UIView()
        selectedBackgroundColorView.backgroundColor = UIColor(red: 0.96, green: 0.82, blue: 0.4, alpha: 0.8)

        selectedBackgroundView = selectedBackgroundColorView
        backgroundColor = UIColor(red: 0.97, green: 0.77, blue: 0.36, alpha: 1)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

}

class JournyOptionCell: UITableViewCell {

    @IBOutlet var vehicleImage: UIImageView!
    @IBOutlet var boardingPointLabel: UILabel!
    @IBOutlet var arrivingPointLabel: UILabel!
    @IBOutlet var boardingTimeLabel: UILabel!
    @IBOutlet var arrivingTimeLabel: UILabel!
    @IBOutlet var timeUntilLabel: UILabel!

    override func awakeFromNib() {
        let selectedBackgroundColorView = UIView()
        selectedBackgroundColorView.backgroundColor = UIColor(red: 0.96, green: 0.82, blue: 0.4, alpha: 0.8)

        selectedBackgroundView = selectedBackgroundColorView
        backgroundColor = UIColor(red: 0.97, green: 0.77, blue: 0.36, alpha: 1)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

}