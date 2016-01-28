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

class ClassSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var selectInfoLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var selectState: SelectState = .Institute
    var instituteOptions: JSON = []
    var classOptions: [[String: String]] = [[:]]

    var groupId: String?

    override func viewDidLoad() {
        view.backgroundColor = UIColor(colorCode: "FC9D3D")
        tableView.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1)

        selectInfoLabel.backgroundColor = UIColor.orangeColor()
        selectInfoLabel.textColor = UIColor(white: 0.99, alpha: 0.90)

        navigationController?.navigationBar.barTintColor = view.backgroundColor
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.translucent = false
        
        setNavigationTitle()
        setupTableViewSelection()
    }

    private func setNavigationTitle() {
        switch selectState {
        case .Institute:
            navigationItem.title = "Instituut"

            break
        case .Class:
            navigationItem.title = "Klas"

            break
        }
    }

    private func setupTableViewSelection() {
        switch selectState {
        case .Institute:
            setupInstituteSelection()

            break
        case .Class:
            setupClassSelection(groupId!)

            break
        }
    }

    private func setupInstituteSelection() {
        Client.sharedClient.performRequestWithMethod(.GET, path: "/group/", parameters: nil, completion: fillInstituteOptions)

        selectInfoLabel.text = "Selecteer Instituut"

        tableView.registerNib(UINib(nibName: "InstituteOptionCell", bundle: nil), forCellReuseIdentifier: "InstituteOptionCell")
        tableView.rowHeight = 65.0
    }

    private func fillInstituteOptions(result: JSON) {
        instituteOptions = result

        reloadTableData()
    }

    private func setupClassSelection(groupId: String) {
        tableView.registerNib(UINib(nibName: "ClassOptionCell", bundle: nil), forCellReuseIdentifier: "ClassOptionCell")
        tableView.rowHeight = 55.0

        classOptions.removeAll()

        selectInfoLabel.text = "Selecteer Klas"

        Client.sharedClient.performRequestWithMethod(.GET, path: "/group/" + groupId, parameters: nil, completion: fillClassOptions)
    }

    private func fillClassOptions(result: JSON) {
        let dictionaryValue = result.dictionaryValue

        for(var yearIndex = 0; yearIndex < result.count; yearIndex++) {
            let year: AnyObject = Array(dictionaryValue.keys)[yearIndex]

            if let year = year as? String {
                let classes = result[year]

                for(var classIndex = 0; classIndex < classes.count; classIndex++) {
                    let classId: AnyObject = Array(classes.dictionaryValue.keys)[classIndex]
                    let classValue = classes[classId as! String]

                    if let classId = classId as? String {
                        if !classId.containsString("GET-this") {
                            var classOption: [String: String] = [:]

                            classOption["classId"] = classId
                            classOption["year"] = year
                            classOption["name"] = classValue["name"].stringValue

                            classOptions.append(classOption)
                        }
                    }
                }
            }
        }

        reloadTableData()
    }

    private func reloadTableData() {
        UIView.transitionWithView(tableView, duration:0.65, options:.TransitionCrossDissolve,
            animations: { () -> Void in
                self.tableView.reloadData()
            },
        completion: nil)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectState {
        case .Institute:
            return instituteOptions.count
        case .Class:
            return classOptions.count
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell

        switch selectState {
        case .Institute:
            let instituteOptionCell = tableView.dequeueReusableCellWithIdentifier("InstituteOptionCell", forIndexPath: indexPath) as! InstituteOptionCell

            let key: AnyObject = Array(self.instituteOptions.dictionaryValue.keys)[indexPath.row]
            let value = self.instituteOptions[key as! String]

            instituteOptionCell.setInstituteImage(value["code"].stringValue)
            instituteOptionCell.groupId = key as? String
            instituteOptionCell.nameLabel.text = value["code"].stringValue
            instituteOptionCell.descriptionLabel.text = value["name"].stringValue

            cell = instituteOptionCell
        case .Class:
            let classOptionCell = tableView.dequeueReusableCellWithIdentifier("ClassOptionCell", forIndexPath: indexPath) as! ClassOptionCell
            let classOption = classOptions[indexPath.row]

            classOptionCell.classId = classOption["classId"]
            classOptionCell.yearLabel.text = "Jaar \(classOption["year"]!)"
            classOptionCell.nameLabel.text = classOption["name"]

            cell = classOptionCell
        }

        cell.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1)

        return cell
    }

    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        switch selectState {
        case .Institute:
            let selectViewController = storyboard?.instantiateViewControllerWithIdentifier("ClassSelectViewController") as! ClassSelectViewController
            let selectedCell = tableView.cellForRowAtIndexPath(indexPath) as! InstituteOptionCell

            selectViewController.selectState = .Class
            selectViewController.groupId = selectedCell.groupId!

            navigationController?.pushViewController(selectViewController, animated: true)

            break
        case .Class:
            let classSavedViewController = storyboard?.instantiateViewControllerWithIdentifier("ClassSavedViewController") as! ClassSavedViewController
            let selectedCell = tableView.cellForRowAtIndexPath(indexPath) as! ClassOptionCell

            classSavedViewController.classId = selectedCell.classId!
            classSavedViewController.classYear = selectedCell.yearLabel.text
            classSavedViewController.className = selectedCell.nameLabel.text

            navigationController?.pushViewController(classSavedViewController, animated: true)

            break
        }

        return indexPath
    }

}

class InstituteOptionCell: UITableViewCell {

    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!

    var groupId: String?

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

    func setInstituteImage(institute: String) {
        var image = "school.png"

        switch(institute) {
        case "SAGZ":
            image = "food-apple.png"
        case "SASS":
            image = "comment-account.png"
        case "SITE":
            image = "wrench.png"
        case "SIBS":
            image = "tie.png"
        case "SIBK":
            image = "briefcase.png"
        case "SIFE":
            image = "currency-usd.png"
        case "SIMM":
            image = "instagram.png"
        case "SABC":
            image = "android-studio.png"
        case "SIEN":
            image = "wrench.png"
        case "SCMI":
            image = "content-save.png"
        case "SIFM":
            image = "cube-send.png"
        case "SPEA":
            image = "nature-people.png"
        case "SAVP":
            image = "music-circle.png"
        case "SISP":
            image = "football-helmet.png"
        case "SABK":
            image = "palette.png"
        case "SILS":
            image = "airballoon.png"
        case "SAVK":
            image = "ambulance.png"
        default:
            break
        }

        iconImage.image = UIImage(named: image)?.imageWithRenderingMode(.AlwaysTemplate)
        iconImage.tintColor = UIColor(colorCode: "888888")
    }

}

class ClassOptionCell: UITableViewCell {

    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!

    var classId: String?

}
