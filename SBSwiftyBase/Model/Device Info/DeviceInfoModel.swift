//
//  DeviceInfoModel.swift
//  SBSwiftyBase
//
//  Created by support on 12/29/17.
//  Copyright © 2017 SANKARLAL. All rights reserved.
//

import UIKit

class DeviceInfoModel: NSObject {

    class func getDeviceInfo() -> [String : Any] {
        
        let myDevice : UIDevice = UIDevice.current
        
        let deviceName : String = myDevice.name
        let deviceSystemName : String = myDevice.systemName
        let deviceOSVersion : String = myDevice.systemVersion
        let deviceModel : String = myDevice.model
        let deviceLocalizedModel : String = myDevice.localizedModel

        let languageArray : [Any] = NSLocale.preferredLanguages
        let language : String = languageArray[0] as! String
        
        let locale : Locale  = NSLocale.current
        let country : String = locale.identifier
        
        
        let appVersion : String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let appBuild : String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        let appName : String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String

        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryLevel : Float = UIDevice.current.batteryLevel * 100
        let batteryState : Int = UIDevice.current.batteryState.rawValue

        var batteryStateValue : String = ""
        
        switch batteryState {
        case 0:
            batteryStateValue = "Unknown"
        case 1:
            batteryStateValue = "Unplugged"
        case 2:
            batteryStateValue = "Charging"
        case 4:
            batteryStateValue = "Full"

        default:
            break
        }
        
        let dict_DeviceInfo : [String : Any] = ["deviceName" : deviceName,
                                                "deviceSystemName" : deviceSystemName,
                                                "deviceOSVersion" : deviceOSVersion,
                                                "deviceModel" : deviceModel,
                                                "deviceLocalizedModel" : deviceLocalizedModel,
                                                "language" : language,
                                                "country" : country,
                                                "appVersion" : appVersion,
                                                "appBuild" : appBuild,
                                                "appName" : appName,
                                                "batteryLevel" : batteryLevel,
                                                "batteryState" : batteryStateValue]
        
        return dict_DeviceInfo
        
    }
}
