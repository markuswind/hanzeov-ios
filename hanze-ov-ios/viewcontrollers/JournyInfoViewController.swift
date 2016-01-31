//
//  JournyInfoViewController.swift
//  hanze-ov-ios
//
//  Created by Markus Wind on 1/28/16.
//  Copyright © 2016 Markus Wind. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class JournyInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var selectionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var startImageView: UIImageView!
    @IBOutlet weak var typeImageView: UIImageView!

    @IBOutlet weak var boardingLocationLabel: UILabel!
    @IBOutlet weak var desitnationLocationLabel: UILabel!
    @IBOutlet weak var boardingTimeLabel: UILabel!
    @IBOutlet weak var arrivingTimeLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    var routeLink: String?
    var uid: String?

    var journyInfo: JSON = []

    override func viewDidLoad() {
        tableView.registerNib(UINib(nibName: "JournyOptionCell", bundle: nil), forCellReuseIdentifier: "JournyOptionCell")
        tableView.rowHeight = 80.0
        tableView.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1)

        selectionLabel.backgroundColor = UIColor(red:0.99, green:0.65, blue:0.27, alpha:1)
        selectionLabel.textColor = UIColor.whiteColor()
        
        navigationItem.title = "Reisopties"
        automaticallyAdjustsScrollViewInsets = false

        navigationController?.navigationBar.tintColor = view.backgroundColor
        navigationController?.navigationBar.translucent = false

        startImageView?.image = UIImage(named: "star.png")?.imageWithRenderingMode(.AlwaysTemplate)
        startImageView?.tintColor = UIColor(colorCode: "888888")
        startImageView.userInteractionEnabled = true

        let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("starButtonClicked:"))
        startImageView.addGestureRecognizer(tapRecognizer)

        typeImageView?.image = UIImage(named: "bus.png")?.imageWithRenderingMode(.AlwaysTemplate)
        typeImageView?.tintColor = UIColor(colorCode: "888888")

        Client.sharedClient.performRequestWithMethod(.GET, path: "/" + routeLink!, parameters: nil, completion: fillJournyInfo)
    }

    private func fillJournyInfo(result: JSON) {
        for(var index = 0; index < result.count; index++) {
            if(result[index]["uid"].stringValue == uid) {
                journyInfo = result[index]
            }
        }

        updateLabels()

        tableView.reloadData()
    }

    private func updateLabels() {
        let firstPartValue = journyInfo["parts"][0]
        let lastPartValue = journyInfo["parts"][journyInfo["parts"].count - 1]
        let firstStopsValue = firstPartValue["stops"]
        let lastStopsValue = lastPartValue["stops"]

        boardingLocationLabel.text = "\(firstStopsValue[0]["location"]) - \(firstStopsValue[0]["place"])"
        desitnationLocationLabel.text = "\(lastStopsValue[lastStopsValue.count - 1]["location"]) - \(lastStopsValue[lastStopsValue.count - 1]["place"])"
        boardingTimeLabel.text = journyInfo["departure_time"].stringValue
        arrivingTimeLabel.text = journyInfo["arrival_time"].stringValue

        numberLabel.text = "\(firstPartValue["number"]) (\(journyInfo["num_changes"])x overstappen)"

        dateLabel.text = journyInfo["departure_date"].stringValue
    }

    func starButtonClicked(gestureRecognizer: UITapGestureRecognizer) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let token = defaults.valueForKey("token")

        // FIXME:: --workaround; should use sharedClient (token should be added from there)
        let parameters = [
            "uid": uid!,
        ]

        if let _ = token {
            Alamofire.request(.POST, "http://localhost:8000/reservation/" + (token! as! String), parameters: parameters).responseJSON { response in
                if let _ = response.response {
                    self.startImageView.tintColor = UIColor.orangeColor()
                }
            }
        } else {
            print("user is not logged in, should show alert or something")
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journyInfo["parts"].count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("JournyOptionCell", forIndexPath: indexPath) as! JournyOptionCell

        let partValue = journyInfo["parts"][indexPath.row]
        let firstStopValue = partValue["stops"][0]
        let lastStopValue = partValue["stops"][partValue["stops"].count - 1]

        // set label texts
        cell.departureLocationLabel.text = firstStopValue["location"].stringValue + " - " + firstStopValue["place"].stringValue
        cell.arrivalLocationLabel.text = lastStopValue["location"].stringValue + " - " + lastStopValue["place"].stringValue
        cell.departureTimeLabel.text = stripTimeString(firstStopValue["departure"].stringValue)
        cell.arrivalTimeLabel.text = ""
        cell.numberLabel.text = partValue["number"].stringValue
        cell.dateLabel.text = ""

        // set image
        cell.modeImageView?.image = UIImage(named: "bus.png")?.imageWithRenderingMode(.AlwaysTemplate)
        cell.modeImageView?.tintColor = UIColor(colorCode: "888888")
        
        return cell
    }

    private func stripTimeString(string: String) -> String {
        let subStr = string[string.startIndex.advancedBy(11)...string.startIndex.advancedBy(15)]

        return subStr
    }

    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return indexPath
    }

}