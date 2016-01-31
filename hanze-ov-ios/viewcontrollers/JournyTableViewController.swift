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

        let defaults = NSUserDefaults.standardUserDefaults()
        let location = defaults.valueForKey("location")

        if location != nil {
            routeLink = routeLink?.replace("Groningen", withString: location as! String)
        }

        routeLink = routeLink?.replace(" ", withString: "%20")

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
        let firstPartValue = value["parts"][0]
        let lastPartValue = value["parts"][value["parts"].count - 1]
        let stopsValue = firstPartValue["stops"]

        // set uuid for use in info view
        cell.uid = value["uid"].stringValue

        // set label texts
        cell.departureLocationLabel.text = stopsValue[0]["location"].stringValue ?? "Locatie onbekend"
        cell.arrivalLocationLabel.text = lastPartValue["destination"].stringValue ?? "Locatie onbekend"
        cell.departureTimeLabel.text = value["departure_time"].stringValue ?? "-"
        cell.arrivalTimeLabel.text = value["arrival_time"].stringValue ?? "-"
        cell.numberLabel.text = "\(firstPartValue["number"]) (\(value["num_changes"])x overstappen)"
        cell.dateLabel.text = value["departure_date"].stringValue ?? "??/??/??"

        // set image
        cell.modeImageView?.image = UIImage(named: "bus.png")?.imageWithRenderingMode(.AlwaysTemplate)
        cell.modeImageView?.tintColor = UIColor(colorCode: "888888")

        return cell
    }

    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        let journyInfoViewController = storyboard?.instantiateViewControllerWithIdentifier("JournyInfoViewController") as! JournyInfoViewController
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath) as! JournyOptionCell

        journyInfoViewController.routeLink = routeLink
        journyInfoViewController.uid = selectedCell.uid

        navigationController?.pushViewController(journyInfoViewController, animated: true)

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

    var uid: String?

}