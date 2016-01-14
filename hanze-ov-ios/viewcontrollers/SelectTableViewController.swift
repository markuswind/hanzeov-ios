//
//  SelectTableViewController.swift
//  hanze-ov-ios
//
//  Created by Markus Wind on 11/01/16.
//  Copyright © 2016 Markus Wind. All rights reserved.
//

import UIKit

enum SelectState {
    case Institute
    case Class
}

class SelectTableViewController: UITableViewController {

    var selectState: SelectState = .Institute

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
        tableView.registerNib(UINib(nibName: "InstituteOptionCell", bundle: nil), forCellReuseIdentifier: "InstituteOptionCell")
        tableView.rowHeight = 65.0
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
            return 10
        case .Class:
            return 30
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell

        switch selectState {
        case .Institute:
            cell = tableView.dequeueReusableCellWithIdentifier("InstituteOptionCell", forIndexPath: indexPath) as! InstituteOptionCell
        case .Class:
            cell = tableView.dequeueReusableCellWithIdentifier("ClassOptionCell", forIndexPath: indexPath) as! ClassOptionCell
        }

        return cell
    }

    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        switch selectState {
        case .Institute:
            selectState = .Class

            setupTableView()
            
            break
        case .Class:
            self.performSegueWithIdentifier("classSelectedSeque", sender: self)

            break
        }

        return indexPath
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
        backgroundColor = UIColor(red: 0.97, green: 0.77, blue: 0.36, alpha: 1)
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

    override func awakeFromNib() {
        super.awakeFromNib()

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