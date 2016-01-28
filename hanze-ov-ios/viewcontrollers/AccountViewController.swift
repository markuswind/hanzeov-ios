//
//  AccountViewController.swift
//  hanze-ov-ios
//
//  Created by Markus Wind on 1/28/16.
//  Copyright © 2016 Markus Wind. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!

    override func viewDidLoad() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let location = defaults.valueForKey("location")

        if location != nil {
            addressTextField.text = location as? String
            addressLabel.text = location as? String
        }
    }

    @IBAction func saveButtonClicked(sender: UIButton!) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(addressTextField.text!, forKey: "location")

        addressLabel.text = addressTextField.text!
    }

    @IBAction func loginButtonClicked(sender: UIButton!) {
        let loginViewController = storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController

        navigationController?.pushViewController(loginViewController, animated: true)
    }

}