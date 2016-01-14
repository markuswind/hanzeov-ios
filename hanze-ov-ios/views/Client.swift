//
//  Client.swift
//  hanze-ov-ios
//
//  Created by Markus Wind on 1/11/16.
//  Copyright © 2016 Markus Wind. All rights reserved.
//

import Alamofire

class Client {

    class var sharedClient: Client {
        struct Singleton {
            static let instance = Client()
        }

        return Singleton.instance
    }

    private func performRequestWithMethod(method: Alamofire.Method, path: String, parameters: [String: AnyObject], completion: () -> ()) {
        Alamofire.request(method, path, parameters: parameters).responseJSON { response in
            if let _ = response.response {
                if let rawObject = response.result.value as? NSDictionary {
                    print(rawObject)
                }
            }
        }
    }
}
