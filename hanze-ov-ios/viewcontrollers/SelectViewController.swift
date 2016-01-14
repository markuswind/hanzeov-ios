//
//  ViewController.swift
//  hanze-ov-ios
//
//  Created by Markus Wind on 1/10/16.
//  Copyright © 2016 Markus Wind. All rights reserved.
//

import UIKit
import Alamofire

class SelectViewController: UIViewController {

    @IBOutlet weak var selectionInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red:0.96, green:0.8, blue:0.36, alpha:1)

        // setup table view
        loadInstituteOptions()
    }

    private func loadInstituteOptions() {
        selectionInfoLabel.text = "selecteer instituut"
    }

    @IBAction func instituteSelected() {
        loadClassOptions()
    }

    private func loadClassOptions() {
        selectionInfoLabel.text = "selecteer rooster"
    }

    @IBAction func classSelected() {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

