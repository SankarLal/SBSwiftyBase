//
//  PushNotification.swift
//  SBSwiftyBase
//
//  Created by support on 12/29/17.
//  Copyright © 2017 SANKARLAL. All rights reserved.
//

import UIKit
import UserNotifications


/**
  PushNotification Model Class manage the APNS stuff.
 Registering and Receiving the Push Notificaton based on iOS versions.
 */
class PushNotification: NSObject {


    /**
     Initialise the Push Notification
 */
   class func initialisePushNotifications() {
        APP_DELEGATE_INSTANCE.startRegistrationForPushNotification()
    }
}


extension AppDelegate {
    
    /**
     Registering Push Notification based on iOS versions.
     
     ## if #available(iOS 10.0, *)
     It means this will work only on iOS 10 version device
     
     ## @available(iOS 10, *)
     It means the extension class will work only on iOS 10 version device
 */
    
    func startRegistrationForPushNotification() {
       
        if #available(iOS 10.0, *) {
            
            UNUserNotificationCenter.current().delegate = self
            
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                
                // FCM
                self.registerFCMRemoteMessageDelegate()

            }
            
        } else {
            let settings : UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            
        }
        
        // FCM
        self.setUpFCMConfig()

        UIApplication.shared.registerForRemoteNotifications()

    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
//        print("deviceTokenString \(deviceTokenString)")
        
        // FCM
        self.setAPNSTokenToFCMServer(deviceToken)

        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("APNS ERROR", error.localizedDescription)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        // FCM - Print message ID.
        self.receivedRemoteNotificationMessage(userInfo)
        handlePushNotificationMessage(userInfo as! [String : Any])

        completionHandler(UIBackgroundFetchResult.newData)
    }
}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo

        // FCM - Print message ID.
        self.receivedRemoteNotificationMessage(userInfo)
        handlePushNotificationMessage(userInfo as! [String : Any])

        completionHandler()

    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
       
        let userInfo = notification.request.content.userInfo
        
        // FCM - Print message ID.
        self.receivedRemoteNotificationMessage(userInfo)
        handlePushNotificationMessage(userInfo as! [String : Any])

        completionHandler( [.alert,.sound, .badge])

    }
    
}


extension AppDelegate {
    
    func handlePushNotificationMessage(_ value : [String : Any]) {
        
    }
}


