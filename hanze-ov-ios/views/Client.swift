//
//  Client.swift
//  hanze-ov-ios
//
//  Created by Markus Wind on 1/11/16.
//  Copyright © 2016 Markus Wind. All rights reserved.
//

import Alamofire
import SwiftyJSON

class Client {

    let base_url = "http://localhost:8000"

    class var sharedClient: Client {
        struct Singleton {
            static let instance = Client()
        }

        return Singleton.instance
    }

    func performRequestWithMethod(method: Alamofire.Method, path: String, parameters: [String: AnyObject]?, completion: (JSON) -> ()) {
        Alamofire.request(method, base_url + path, parameters: parameters).responseJSON { response in
            if let _ = response.response {
                completion(JSON(response.result.value!))
            }
        }
    }

}
