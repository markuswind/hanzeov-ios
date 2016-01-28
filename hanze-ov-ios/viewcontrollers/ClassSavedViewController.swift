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
        navigationItem.title = "Rooster opslaan"
        view.backgroundColor = UIColor(colorCode: "FC9D3D")

        classLabel.text = "\(className!) (\(classYear!))"

        button.layer.cornerRadius = 5.0
    }

    @IBAction func buttonPressed(sender: UIButton!) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(classId, forKey: "classId")

        let homeViewController = storyboard?.instantiateViewControllerWithIdentifier("TabBarController")
        presentViewController(homeViewController!, animated: true, completion: nil)
    }

}