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

    @IBOutlet weak var loginStatusLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!

    override func viewDidLoad() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let location = defaults.valueForKey("location")
        let token = defaults.valueForKey("token")

        if location != nil {
            addressTextField.text = location as? String
            addressLabel.text = location as? String
        }

        if token != nil {
            loginStatusLabel.text = "U bent ingelogd"
            loginButton.enabled = false
            logoutButton.enabled = true
        }
    }

    @IBAction func saveButtonClicked(sender: UIButton!) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(addressTextField.text!, forKey: "location")

        addressLabel.text = addressTextField.text!
    }

    @IBAction func editScheduleButtonClicked(sender: UIButton!) {
        let classSelectViewControler = storyboard?.instantiateViewControllerWithIdentifier("ClassSelectViewController") as! ClassSelectViewController

        navigationController?.pushViewController(classSelectViewControler, animated: true)
    }

    @IBAction func loginButtonClicked(sender: UIButton!) {
        let loginViewController = storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController

        navigationController?.pushViewController(loginViewController, animated: true)
    }

    @IBAction func logoutButtonClicked(sender: UIButton!) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("token")

        loginButton.enabled = true
        logoutButton.enabled = false
    }

}