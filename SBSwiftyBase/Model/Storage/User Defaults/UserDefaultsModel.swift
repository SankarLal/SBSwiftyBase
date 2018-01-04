//
//  UserDefaultsModel.swift
//  SBSwiftyBase
//
//  Created by support on 12/29/17.
//  Copyright © 2017 SANKARLAL. All rights reserved.
//

import UIKit

class UserDefaultsModel: NSObject {

    private class func userDefaults() -> UserDefaults {
        return UserDefaults.standard
    }
    
    class func setObject (_ object : Any?, forKey : String) {
        userDefaults().set(object, forKey: forKey)
        userDefaults().synchronize()
    }
    
    class func removeObjectForKey(_ key : String) {
        userDefaults().removeObject(forKey: key)
        userDefaults().synchronize()
    }
    
    class func userLoggedInInfo() -> Dictionary<String, Any>? {
        return userDefaults().dictionary(forKey: USER_LOGGED_IN_KEY)
    }
    
    class func getAPNsDeviceToken() -> String? {
        return userDefaults().string(forKey: APNS_DEVICE_TOKEN_KEY) ?? "123"
    }

}
