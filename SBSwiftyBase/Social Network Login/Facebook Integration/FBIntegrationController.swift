//
//  FBIntegrationController.swift
//  SBSwiftyBase
//
//  Created by support on 12/29/17.
//  Copyright © 2017 SANKARLAL. All rights reserved.
//

import Foundation
import UIKit
import FacebookCore
import FacebookLogin


extension UIViewController {
    
    //MARK: - Facebook Login
    func loginWithFacebook(successHandler: @escaping SuccessHandler, failHandler: @escaping FailHandler) {
        
        successCompletionHandler = successHandler
        failCompletionHandler = failHandler
        
        if(AccessToken.current == nil) {
            let loginManager = LoginManager()
            loginManager.logIn(readPermissions(), viewController: self) { loginResult in
                self.loginManagerDidComplete(loginResult)
            }
            
        } else {
            self.getUserInfoFromFB()
        }
    }
    
    private func loginManagerDidComplete(_ loginResult: LoginResult) {
        
        switch loginResult {
            
        case .failed(let error):
            failCompletionHandler!(error.localizedDescription as AnyObject)
            self.updateCompletionHandler()
            
        case .cancelled:
            failCompletionHandler!("User cancelled login." as AnyObject)
            self.updateCompletionHandler()

        case .success(let grantedPermissions, let declinedPermissions, let tocken):
            AccessToken.current = tocken
            print("grantedPermissions", grantedPermissions)
            print("declinedPermissions", declinedPermissions)
            print("tocken", tocken)
            getUserInfoFromFB()
        }
    }
    
    private func getUserInfoFromFB() {
        
        let params = ["fields":"cover,picture.type(large),id,name,first_name,last_name,gender,birthday,email,location,hometown"]
        let graphRequest = GraphRequest(graphPath: "me", parameters: params)
        
        graphRequest.start {
            (urlResponse, requestResult) in
            
            switch requestResult {
                
            case .failed(let error):
                failCompletionHandler!(error.localizedDescription as AnyObject)
                self.updateCompletionHandler()

            case .success(let graphResponse):
                
                if let responseDictionary = graphResponse.dictionaryValue {
                    successCompletionHandler!(responseDictionary as AnyObject)
                    self.updateCompletionHandler()
                    
                }
            }
        }
        
    }
    
    func logoutFromFacebook() {
        let loginManager = LoginManager()
        loginManager.logOut()
    }
    
    private func readPermissions() -> [ReadPermission] {
        return [.publicProfile, .email]
    }
    
    private func publishPermissions() -> [PublishPermission] {
        return [.publishActions]
    }
    
    private func updateCompletionHandler() {
        successCompletionHandler = nil
        failCompletionHandler = nil
    }
}


extension UIViewController: LoginButtonDelegate {
    
    public func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        print("Did complete login via LoginButton with result \(result)")
    }
    
    public func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("Did logout via LoginButton")
        
    }
}
