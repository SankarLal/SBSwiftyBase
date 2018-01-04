//
//  Connectivity.swift
//  SBSwiftyBase
//
//  Created by support on 12/29/17.
//  Copyright © 2017 SANKARLAL. All rights reserved.
//

import UIKit
import Alamofire

class Connectivity: NSObject {

    class func checkNetworkAvailbility() {
        
        var isNetworkReachable : Bool = false
        
        let net = NetworkReachabilityManager()
        net?.startListening()
        
        net?.listener = {status in
            
            if  net?.isReachable ?? false {
                
                if ((net?.isReachableOnEthernetOrWiFi) != nil) {
                    //do some stuff
                }else if(net?.isReachableOnWWAN)! {
                    //do some stuff
                }
                
                print("have connection")
                isNetworkReachable = true
            }
            else {
                
                isNetworkReachable = false
                print("no connection")
            }
            
            NotificationCenter.default.post(name: NSNotification.Name(n_NOTIFY_NETWORK_STATUS),
                                            object: nil,
                                            userInfo: ["isNetworkReachable" : isNetworkReachable])
        }
    }
}
