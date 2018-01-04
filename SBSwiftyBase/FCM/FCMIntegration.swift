//
//  FCMIntegration.swift
//  SBSwiftyBase
//
//  Created by support on 12/29/17.
//  Copyright © 2017 SANKARLAL. All rights reserved.
//

import Foundation
import UIKit
import Firebase


let gcmMessageIDKey = "gcm.message_id"


// FCM
extension AppDelegate {
    
    // FCM - For iOS 10 data message (sent via FCM)
    func registerFCMRemoteMessageDelegate () {
        FIRMessaging.messaging().remoteMessageDelegate = self

    }
    
    func setUpFCMConfig() {
        
        FIRApp.configure()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.tokenRefreshNotification),
                                               name: .firInstanceIDTokenRefresh,
                                               object: nil)

    }
    
    func setAPNSTokenToFCMServer(_ deviceToken : Data) {
        
        FIRInstanceID.instanceID().setAPNSToken(deviceToken, type:FIRInstanceIDAPNSTokenType.sandbox)
        FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: FIRInstanceIDAPNSTokenType.prod)

    }
    
    func receivedRemoteNotificationMessage(_ userInfo: [AnyHashable : Any]) {
       
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)", userInfo)
        }

    }
    
    @objc func tokenRefreshNotification(_ notification: Notification) {

        updateTokenToServer()
        // Connect to FCM since connection may have failed when attempted before having a token.
        connectToFCM()
    }
    
    func updateTokenToServer() {
        
        if let refreshedToken = FIRInstanceID.instanceID().token() {
            print("InstanceID token: \(refreshedToken)")
            UserDefaultsModel.setObject(refreshedToken, forKey: APNS_DEVICE_TOKEN_KEY)
        }
    }

    // FCM
    func connectToFCM() {
        // Won't connect since there is no token
        guard FIRInstanceID.instanceID().token() != nil else {
            return
        }
        
        // Disconnect previous FCM connection if it exists.
        FIRMessaging.messaging().disconnect()
        
        FIRMessaging.messaging().connect { (error) in
            if error != nil {
                print("Unable to connect with FCM. \(error?.localizedDescription ?? "")")
            } else {
                print("Connected to FCM.")
            }
        }
    }
    
}


// FCM Delegate Function
extension AppDelegate : FIRMessagingDelegate {
    // Receive data message on iOS 10 devices while app is in the foreground.
    func applicationReceivedRemoteMessage(_ remoteMessage: FIRMessagingRemoteMessage) {
        print("Message Data: \(remoteMessage.appData)", remoteMessage)
        
    }
}
