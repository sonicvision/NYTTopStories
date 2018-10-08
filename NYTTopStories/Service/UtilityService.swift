//
//  UtilityService.swift
//  NYTTopStories
//
//  Created by Aarti Rustagi on 08/10/18.
//  Copyright © 2018 Proapptive Solutions. All rights reserved.
//

import Foundation

class UtilityService {
    static func fetchValueFromPlist(keyName:String) -> String {
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            let dictRoot = NSDictionary(contentsOfFile: path)
            if let dict = dictRoot {
                return dict[keyName] as! String
            }
        }
        return "VALUE_NOT_FOUND"
    }
}
