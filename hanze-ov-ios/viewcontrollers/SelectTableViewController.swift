//
//  SelectTableViewController.swift
//  hanze-ov-ios
//
//  Created by Markus Wind on 11/01/16.
//  Copyright © 2016 Markus Wind. All rights reserved.
//

import UIKit
import SwiftyJSON

enum SelectState {
    case Institute
    case Class
}

class SelectTableViewController: UITableViewController {

    var selectState: SelectState = .Institute
    var instituteOptions: JSON = []

    override func viewDidLoad() {
        themeTableView()
        setupTableView()
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
        case .Institute:
            setupInstituteSelection()
        case .Class:
            setupClassSelection()
        }
    }

    private func setupInstituteSelection() {
        Client.sharedClient.performRequestWithMethod(.GET, path: "/group/", parameters: nil, completion: fillInstituteOptions)

        tableView.registerNib(UINib(nibName: "InstituteOptionCell", bundle: nil), forCellReuseIdentifier: "InstituteOptionCell")
        tableView.rowHeight = 65.0
    }

    private func fillInstituteOptions(result: JSON) {
        instituteOptions = result

        reloadTableData()
    }

    private func setupClassSelection() {
        tableView.registerNib(UINib(nibName: "ClassOptionCell", bundle: nil), forCellReuseIdentifier: "ClassOptionCell")
        tableView.rowHeight = 55.0

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
        case .Institute:
            return instituteOptions.count
        case .Class:
            return 30
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell

        switch selectState {
        case .Institute:
            let instituteOptionCell = tableView.dequeueReusableCellWithIdentifier("InstituteOptionCell", forIndexPath: indexPath) as! InstituteOptionCell

            let key: AnyObject = Array(self.instituteOptions.dictionaryValue.keys)[indexPath.row]
            let value = self.instituteOptions[key as! String]

            instituteOptionCell.nameLabel.text = value["code"].stringValue
            instituteOptionCell.descriptionLabel.text = value["name"].stringValue

            cell = instituteOptionCell
        case .Class:
            cell = tableView.dequeueReusableCellWithIdentifier("ClassOptionCell", forIndexPath: indexPath) as! ClassOptionCell
        }

        styleTableCell(cell, row: indexPath.row)

        return cell
    }

    private func styleTableCell(cell: UITableViewCell, row: Int) {
        let selectedBackgroundView = UIView()

        if (row % 2 == 0) {
            cell.backgroundColor = UIColor(red: 0.96, green: 0.82, blue: 0.4, alpha: 1.0)
            selectedBackgroundView.backgroundColor = UIColor(red: 0.96, green: 0.75, blue: 0.4, alpha: 0.8)
        } else {
            cell.backgroundColor = UIColor(red: 0.96, green: 0.75, blue: 0.4, alpha: 1.0)
            selectedBackgroundView.backgroundColor = UIColor(red: 0.96, green: 0.82, blue: 0.4, alpha: 0.8)
        }

        cell.selectedBackgroundView = selectedBackgroundView
    }

    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        switch selectState {
        case .Institute:
            selectState = .Class

            setupTableView()
            updateNavigationBar()
            
            break
        case .Class:
            let scheduleViewController = storyboard?.instantiateViewControllerWithIdentifier("ScheduleViewController")
            navigationController?.pushViewController(scheduleViewController!, animated: true)

            break
        }

        return indexPath
    }

    private func updateNavigationBar() {
        let backButton = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: "backButtonPressed")

        navigationController?.navigationBar.topItem?.title = "Rooster"
        navigationController?.navigationItem.leftBarButtonItem = backButton
    }

    private func backButtonPressed() {
        print("backButtonPressed()")
    }

}

class InstituteOptionCell: UITableViewCell {

    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!

    var id: String?

    override func awakeFromNib() {
        super.awakeFromNib()

        let selectedBackgroundColorView = UIView()
        selectedBackgroundColorView.backgroundColor = UIColor(red: 0.96, green: 0.82, blue: 0.4, alpha: 0.8)

        selectedBackgroundView = selectedBackgroundColorView
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

}

class ClassOptionCell: UITableViewCell {

    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!

    var id: String?

}
