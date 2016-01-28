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
            let startTime = getDateFromMilliseconds(item["start"].int!)
            let endTime = getDateFromMilliseconds(item["end"].int!)

            if(endTime.timeIntervalSince1970 > NSDate().timeIntervalSince1970) {
                let scheduleOption = createScheduleOption(item, startTime: startTime, endTime: endTime)

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

    func createScheduleOption(item: JSON, startTime: NSDate, endTime: NSDate) -> [String : String] {
        // get all calendar data
        let calendar = NSCalendar.currentCalendar()

        let startDay = calendar.components(NSCalendarUnit.Day, fromDate: startTime)
        let startMonth = calendar.component(NSCalendarUnit.Month, fromDate: startTime)

        let startHour = calendar.component(NSCalendarUnit.Hour, fromDate: startTime)
        let startMinute = calendar.component(NSCalendarUnit.Minute, fromDate: startTime)

        let endHour = calendar.component(NSCalendarUnit.Hour, fromDate: endTime)
        let endMinute = calendar.component(NSCalendarUnit.Minute, fromDate: endTime)

        // create schedule option
        var scheduleOption: [String : String] = [:]
        scheduleOption["id"] = item["id"].stringValue
        scheduleOption["link"] = item["GET-route"].stringValue
        scheduleOption["date"] = "\(startDay.day)/\(startMonth)"
        scheduleOption["name"] = item["description"].stringValue
        scheduleOption["location"] = item["location"].stringValue
        scheduleOption["staff"] = item["staff"].stringValue
        scheduleOption["time"] = "\(startHour):\(startMinute) - \(endHour):\(endMinute)"

        return scheduleOption
    }

    func getStringFromDate(date: NSDate, format: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format

        return dateFormatter.stringFromDate(NSDate())
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleOptions.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ScheduleOptionCell", forIndexPath: indexPath) as! ScheduleOptionCell
        let scheduleOption = scheduleOptions[indexPath.row]

        cell.link = scheduleOption["link"]

        cell.nameLabel.text = scheduleOption["name"]
        cell.dateLabel.text = scheduleOption["date"]
        cell.timeLabel.text = scheduleOption["time"]
        cell.locationLabel.text = scheduleOption["location"]
        cell.staffLabel.text = scheduleOption["staff"]

        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let journyTableViewController = storyboard?.instantiateViewControllerWithIdentifier("JournyTableViewController") as! JournyTableViewController
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath) as! ScheduleOptionCell

        journyTableViewController.routeLink = selectedCell.link

        navigationController?.pushViewController(journyTableViewController, animated: true)
    }

}

class ScheduleOptionCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var staffLabel: UILabel!

    var link: String?

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
