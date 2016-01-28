//
//  ReservationsViewController.swift
//  hanze-ov-ios
//
//  Created by Markus Wind on 1/28/16.
//  Copyright © 2016 Markus Wind. All rights reserved.
//

import UIKit
import SwiftyJSON

class ReservationsTableViewController: UITableViewController {

    var reservations: JSON = []

    override func viewDidLoad() {
        tableView.registerNib(UINib(nibName: "ReservationCell", bundle: nil), forCellReuseIdentifier: "ReservationCell")
        tableView.rowHeight = 80.0
        tableView.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1)

        navigationItem.title = "Reserveringen"
        automaticallyAdjustsScrollViewInsets = false

        navigationController?.navigationBar.tintColor = view.backgroundColor
        navigationController?.navigationBar.translucent = false

        loadReservations()
    }

    override func viewWillAppear(animated: Bool) {
       loadReservations()
    }

    private func loadReservations() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let token = defaults.valueForKey("token")

        if let _ = token {
            Client.sharedClient.performRequestWithMethod(.GET, path: "/reservation/" + (token as! String), parameters: nil, completion: fillJournyOptions)
        } else {
            print("user is not logged, should show message/warning")
        }
    }

    private func fillJournyOptions(result: JSON) {
        reservations = result

        tableView.reloadData()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reservations.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ReservationCell", forIndexPath: indexPath) as! ReservationCell
        let value = reservations["\(indexPath.row + 1)"]

        cell.dateLabel.text = value["created"].stringValue
        cell.routeUid = value["routeUid"].stringValue
        cell.link = value["GET-reservation"].stringValue

        return cell
    }

}

class ReservationCell: UITableViewCell {

    @IBOutlet var dateLabel: UILabel!

    var routeUid: String?
    var link: String?

}