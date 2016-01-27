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
        view.backgroundColor = UIColor(colorCode: "FC9D3D")

        classLabel.text = "\(className!) (\(classYear!))"
    }

    @IBAction func buttonPressed(sender: UIButton!) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(classId, forKey: "classId")

        print("NSUserDefaults: saved \(classId) forKey: classId")

        // Switch to home view
        let homeViewController = storyboard?.instantiateViewControllerWithIdentifier("TabBarController")
        presentViewController(homeViewController!, animated: true, completion: nil)
    }

}