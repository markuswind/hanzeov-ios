//
//  String+Replace.swift
//  hanze-ov-ios
//
//  Created by Markus Wind on 1/28/16.
//  Copyright © 2016 Markus Wind. All rights reserved.
//

import Foundation

extension String {

    func replace(target: String, withString: String) -> String {
        return self.stringByReplacingOccurrencesOfString(target, withString: withString, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }

}