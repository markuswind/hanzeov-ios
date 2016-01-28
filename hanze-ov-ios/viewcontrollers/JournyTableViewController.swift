//
//  JournyTableViewController.swift
//  hanze-ov-ios
//
//  Created by Markus Wind on 1/14/16.
//  Copyright © 2016 Markus Wind. All rights reserved.
//

import UIKit
import SwiftyJSON

class JournyTableViewController: UITableViewController {

    var routeLink: String?
    var journyOptions: JSON = []

    override func viewDidLoad() {
        tableView.registerNib(UINib(nibName: "JournyOptionCell", bundle: nil), forCellReuseIdentifier: "JournyOptionCell")
        tableView.rowHeight = 80.0
        tableView.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1)

        navigationItem.title = "Reisopties"
        automaticallyAdjustsScrollViewInsets = false

        navigationController?.navigationBar.tintColor = view.backgroundColor
        navigationController?.navigationBar.translucent = false

        routeLink = routeLink?.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet())

        Client.sharedClient.performRequestWithMethod(.GET, path: "/" + routeLink!, parameters: nil, completion: fillJournyOptions)
    }

    private func fillJournyOptions(result: JSON) {
        journyOptions = result

        tableView.reloadData()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journyOptions.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("JournyOptionCell", forIndexPath: indexPath) as! JournyOptionCell

        let value = journyOptions[indexPath.row]
        let partsValue = value["parts"]
        let stopsValue = partsValue["stops"]

        cell.link = value["GET-route"].stringValue

        cell.departureLocationLabel.text = stopsValue[0]["location"].stringValue ?? "Locatie onbekend"
        cell.arrivalLocationLabel.text = partsValue["destination"].stringValue ?? "Locatie onbekend"
        cell.departureTimeLabel.text = value["departure_time"].stringValue ?? "-"
        cell.arrivalTimeLabel.text = value["arrival_time"].stringValue ?? "-"
        cell.numberLabel.text = partsValue["number"].stringValue ?? "??"
        cell.dateLabel.text = value["departure_date"].stringValue ?? "??/??/??"

        cell.modeImageView?.image = UIImage(named: "bus.png")?.imageWithRenderingMode(.AlwaysTemplate)
        cell.modeImageView?.tintColor = UIColor(colorCode: "888888")

        return cell
    }

    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
//        let selectViewController = storyboard?.instantiateViewControllerWithIdentifier("JournyInfoViewController") as! JournyInfoViewController
//        let selectedCell = tableView.cellForRowAtIndexPath(indexPath) as! JournyOptionCell

//        journyInfoViewController.link = selectedCell.link!

//        navigationController?.pushViewController(JournyInfoViewController, animated: true)

        return indexPath
    }
    
}

class JournyOptionCell: UITableViewCell {

    @IBOutlet var modeImageView: UIImageView!
    @IBOutlet var departureLocationLabel: UILabel!
    @IBOutlet var arrivalLocationLabel: UILabel!
    @IBOutlet var departureTimeLabel: UILabel!
    @IBOutlet var arrivalTimeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!

    var link: String?

}