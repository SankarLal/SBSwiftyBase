//
//  GoogleIntegrationController.swift
//  SBSwiftyBase
//
//  Created by support on 12/29/17.
//  Copyright © 2017 SANKARLAL. All rights reserved.
//

import Foundation
import UIKit
import Google
import GoogleSignIn

extension UIViewController : GIDSignInDelegate, GIDSignInUIDelegate {
    
    func loginWithGoogle(successHandler: @escaping SuccessHandler, failHandler: @escaping FailHandler) {
       
        successCompletionHandler = successHandler
        failCompletionHandler = failHandler

        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    func logoutFromGoogle() {
        GIDSignIn.sharedInstance().signOut()
        
    }
    
    //Login Success
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if (error == nil) {
            
            print("UserId     : \(user.userID)")
            print("Token      : \(user.authentication.idToken)")
            print("FullName   : \(user.profile.name)")
            print("GivenName  : \(user.profile.givenName)")
            print("Family Name: \(user.profile.familyName)")
            print("EmailId    : \(user.profile.email)")
            
            successCompletionHandler!(user as AnyObject)
            self.updateCompletionHandler()
        }
        else {
            failCompletionHandler!(error.localizedDescription as AnyObject)
            self.updateCompletionHandler()

        }
        
    }
    
    private func updateCompletionHandler() {
        successCompletionHandler = nil
        failCompletionHandler = nil
    }

    //Login Fail
    public func sign(_ signIn: GIDSignIn!, didDisconnectWith user:GIDGoogleUser!, withError error: Error!) {
        failCompletionHandler!(error.localizedDescription as AnyObject)
        self.updateCompletionHandler()

    }
    
    //****************** Gmail Login Delegate Methods *********************
    
    public func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: false, completion: nil)
    }
    
    
    public func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.dismiss(animated: false, completion: nil)
    }
    

    
}
