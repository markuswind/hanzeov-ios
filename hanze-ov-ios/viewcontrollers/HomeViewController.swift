//
//  HomeViewController.swift
//  hanze-ov-ios
//
//  Created by Markus Wind on 1/26/16.
//  Copyright © 2016 Markus Wind. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var classId: String!
    var scheduleOptions: [[String : String]] = [[:]]

    override func viewDidLoad() {
        let defaults = NSUserDefaults.standardUserDefaults()
        classId = defaults.valueForKey("classId") as? String

        automaticallyAdjustsScrollViewInsets = false

        navigationController?.navigationBar.topItem?.title = "Rooster"
        
        styleViews()
        setupScheduleSelection()
    }

    private func styleViews() {
        view.backgroundColor = UIColor(colorCode: "FC9D3D")
        navigationController?.navigationBar.tintColor = view.backgroundColor
        navigationController?.navigationBar.translucent = false

        tableView.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1)
    }
    
    private func setupScheduleSelection() {
        scheduleOptions.removeAll()

        tableView.registerNib(UINib(nibName: "ScheduleOptionCell", bundle: nil), forCellReuseIdentifier: "ScheduleOptionCell")
        tableView.rowHeight = 90.0

        Client.sharedClient.performRequestWithMethod(.GET, path: "/timetable/" + classId, parameters: nil, completion: fillScheduleOptions)
    }

    private func fillScheduleOptions(result: JSON) {
        let id = Array(result.dictionaryValue.keys)[0]
        let items = result[id]

        for(var index = 0; index < items.count; index++) {
            let item = items[index]
            let endTime = getDateFromMilliseconds(item["end"].int!)

            if(endTime.timeIntervalSince1970 > NSDate().timeIntervalSince1970) {
                var scheduleOption: [String : String] = [:]
                scheduleOption["id"] = item["id"].stringValue
                scheduleOption["link"] = item["GET-route"].stringValue
                scheduleOption["name"] = item["description"].stringValue
                scheduleOption["location"] = item["location"].stringValue
                scheduleOption["staff"] = item["staff"].stringValue
                scheduleOption["start"] = item["start"].stringValue
                scheduleOption["end"] = item["end"].stringValue

                scheduleOptions.append(scheduleOption)
            }
        }

        tableView.reloadData()
    }

    func getDateFromMilliseconds(ms: Int) -> NSDate {
        let interval = NSTimeInterval(ms)
        let date = NSDate(timeIntervalSince1970: interval)

        return date
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleOptions.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ScheduleOptionCell", forIndexPath: indexPath) as! ScheduleOptionCell
        let scheduleOption = scheduleOptions[indexPath.row]

        cell.nameLabel.text = scheduleOption["name"]
        cell.timeLabel.text = "01:00 - 02:00"
        cell.locationLabel.text = scheduleOption["location"]
        cell.staffLabel.text = scheduleOption["staff"]

        return cell
    }

}

class ScheduleOptionCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var staffLabel: UILabel!

    override func awakeFromNib() {
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
