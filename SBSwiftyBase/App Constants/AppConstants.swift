//
//  AppConstants.swift
//  SBSwiftyBase
//
//  Created by support on 12/29/17.
//  Copyright © 2017 SANKARLAL. All rights reserved.
//

import Foundation
import UIKit

/** App Constants class manage the Domain Names
 based on Development and Production enviornment.
 */

//************************************************************************************************

// MARK : AppDelegate Instance

var APP_DELEGATE_INSTANCE : AppDelegate = UIApplication.shared.delegate as! AppDelegate


//************************************************************************************************

// MARK : Server Name
enum ServerName: String {
    
    case Dev            = "http://api.geonames.org/"
    case SQA            = "http://api.geonames.org.sqa/"
    case UAT            = "http://api.geonames.org.uat/"
    case Production     = "http://api.geonames.org.production/"
    
}

let SERVER_NAME : String = ServerName.Dev.rawValue

//************************************************************************************************

let CITIES_SERVICE : String = "citiesJSON?north=44.1&south=-9.9&east=-22.4&west=55.2&lang=de&username=demo"

//************************************************************************************************

// MARK: Storyboard ID's
let SB_HOME_ID : String = "SB_HOME_ID"
let SB_NAVIGATION_BAR_ITEM_ID : String = "SB_NAVIGATION_BAR_ITEM_ID"
let SB_SOCIAL_MEDIA_LOGIN_ID : String = "SB_SOCIAL_MEDIA_LOGIN_ID"
let SB_STORAGE_ID : String = "SB_STORAGE_ID"
let SB_QRCODE_SCANNER_ID : String = "SB_QRCODE_SCANNER_ID"
let SB_WEBSERVICES_ID : String = "SB_WEBSERVICES_ID"
let SB_OTHERS_ID : String = "SB_OTHERS_ID"

//************************************************************************************************

// MARK: Notification Observer Names
let n_LOAD_SIGN_IN_VIEW_CONTROLLER : String = "LOAD_SIGN_IN_VIEW_CONTROLLER"
let n_NOTIFY_NETWORK_STATUS : String = "NOTIFY_NETWORK_STATUS"

//************************************************************************************************

// MARK: User Defaults Key
let USER_LOGGED_IN_KEY : String         = "USER_LOGGED_IN_KEY"
let APNS_DEVICE_TOKEN_KEY : String      = "APNS_DEVICE_TOKEN_KEY"
//************************************************************************************************

// MARK: System Colors
let WHITE_COLOR : UIColor = UIColor.white
let CLEAR_COLOR : UIColor = UIColor.clear
let BLACK_COLOR : UIColor = UIColor.black
let RED_COLOR : UIColor = UIColor.red
let GREEN_COLOR : UIColor = UIColor.green
let HALF_BLACK_COLOR : UIColor = UIColor.black.withAlphaComponent(0.5)

//************************************************************************************************

// MARK: RGB Colors
let APP_NAVIGATION_COLOR : UIColor = UIColor.init(red: 241.0/255.0, green: 241.0/255.0, blue: 243.0/255.0, alpha: 1.0)

//************************************************************************************************

// MARK: Get Top Moset View Controller
 func topMostController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    
    if let navigationController = controller as? UINavigationController {
        return topMostController(controller: navigationController.visibleViewController)
    }
    if let tabController = controller as? UITabBarController {
        if let selected = tabController.selectedViewController {
            return topMostController(controller: selected)
        }
    }
    if let presented = controller?.presentedViewController {
        return topMostController(controller: presented)
    }
    return controller

}

//************************************************************************************************

// MARK: Fonts
enum Fonts: String {
    
    case Helvetica_Regular = "Helvetica"
    case Helvetica_Bold = "Helvetica-Bold"
    
    func font(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
}

//************************************************************************************************

// MARK: Social Network Login Completion Handler
typealias SuccessHandler = (_ success : AnyObject) -> Void
typealias FailHandler = (_ success : AnyObject) -> Void

var successCompletionHandler: SuccessHandler?
var failCompletionHandler: FailHandler?

//************************************************************************************************

