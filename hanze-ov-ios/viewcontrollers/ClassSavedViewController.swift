//
//  ClassSavedViewController.swift
//  hanze-ov-ios
//
//  Created by Markus Wind on 1/26/16.
//  Copyright © 2016 Markus Wind. All rights reserved.
//

import UIKit

class ClassSavedViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var button: UIButton!

    var classId: String?
    var classYear: String?
    var className: String?

    override func viewDidLoad() {
        view.backgroundColor = UIColor(red:0.96, green:0.8, blue:0.36, alpha:1)

        classLabel.text = "\(className!) (\(classYear!)) is ingesteld"
    }

    @IBAction func buttonPressed(sender: UIButton!) {
        print(classId)
        print(classYear)
        print(className)

        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(classId, forKey: "classId")
    }

}