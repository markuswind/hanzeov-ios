//
//  LoginViewController.swift
//  hanze-ov-ios
//
//  Created by Markus Wind on 1/28/16.
//  Copyright © 2016 Markus Wind. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!

    override func viewDidLoad() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let token = defaults.valueForKey("token")

        if let _ = token {
            statusLabel.text = "U bent al ingelogd"
            loginButton.enabled = false
        }
    }

    @IBAction func loginButtonPressed() {
        let parameters = [
            "email": emailTextField.text!,
            "password": passwordTextField.text!
        ]

        Alamofire.request(.POST, "http://localhost:8000/authenticate", parameters: parameters).responseJSON { response in
            if let _ = response.response {
                if let _ = response.data {
                    let token = NSString(data: response.data!, encoding: NSASCIIStringEncoding)

                    let defaults = NSUserDefaults.standardUserDefaults()
                    defaults.setValue(token!, forKey: "token")

                    self.statusLabel.text = "U bent ingelogd!"
                } else {
                    self.statusLabel.text = "Onjuiste email/wachtwoord combinatie"
                }
            }
        }
    }

}