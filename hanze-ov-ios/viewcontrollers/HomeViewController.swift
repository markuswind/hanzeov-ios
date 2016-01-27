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

    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!

    @IBOutlet weak var selectInfoLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var classId: String!
    var scheduleOptions: JSON = []

    override func viewDidLoad() {
        let defaults = NSUserDefaults.standardUserDefaults()
        classId = defaults.valueForKey("classId") as? String

        automaticallyAdjustsScrollViewInsets = false

        navigationController?.navigationBar.topItem?.title = "Overzicht"
        
        styleViews()
        setupScheduleSelection()
    }

    private func styleViews() {
        view.backgroundColor = UIColor(colorCode: "FC9D3D")
        navigationController?.navigationBar.tintColor = view.backgroundColor
        navigationController?.navigationBar.translucent = false

        selectInfoLabel.backgroundColor = UIColor(red: 0.96, green: 0.75, blue: 0.4, alpha: 1.0)
        selectInfoLabel.textColor = UIColor(white: 0.99, alpha: 0.90)
        selectInfoLabel.text = "Rooster"

        tableView.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1)
    }
    
    private func setupScheduleSelection() {
//        Client.sharedClient.performRequestWithMethod(.GET, path: "/timetable/" + classId, parameters: nil, completion: fillScheduleOptions)

        tableView.registerNib(UINib(nibName: "ScheduleOptionCell", bundle: nil), forCellReuseIdentifier: "ScheduleOptionCell")
        tableView.rowHeight = 90.0
    }

    private func fillScheduleOptions(result: JSON) {
        print(result)

        // scheduleOptions = result

        tableView.reloadData()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleOptions.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ScheduleOptionCell", forIndexPath: indexPath) as! ScheduleOptionCell

        // cell.timeLabel.text = ..
        // cell.locationlabel.text = ..
        // cell.nameLabel.text = ..

        return cell
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
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
