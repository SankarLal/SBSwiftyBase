//
//  SocialMediaLoginViewController.swift
//  SBSwiftyBase
//
//  Created by support on 12/29/17.
//  Copyright © 2017 SANKARLAL. All rights reserved.
//

import UIKit
import Google
import GoogleSignIn

class SocialMediaLoginViewController: UIViewController {

    @IBOutlet weak var txtView_Result : UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Social Media Login"
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SocialMediaLoginViewController {
    
    @IBAction func performGoogleLoginButton(sender : UIButton) {
        
        if sender.tag == 2 {
            self.logoutFromGoogle()
            sender.tag = 1
            self.updateGoogleButtonText(sender: sender)
            self.txtView_Result.text = ""
            return
        }
        
        self.loginWithGoogle(successHandler: { (userInfo) in
            print("Google User Info", userInfo)
            if let googelUser = userInfo as? GIDGoogleUser {
                let name : String = (googelUser.profile.name) as String
                let email : String = (googelUser.profile.email) as String
                self.txtView_Result.text = "Google Login Result:\n" + "Name : " + name + "\n" + "Email : " + email
                sender.tag = 2
                self.updateFBButtonText(sender: sender)
            }

        }) { (error) in
            print("Google Login Error", error)
            self.txtView_Result.text = "Google Login Error Result:\n" + (error as! String)
        }
    }
    
    func updateGoogleButtonText(sender : UIButton) {
        if sender.tag == 2 {
            sender.setTitle("Logout", for: .normal)
        } else {
            sender.setTitle("Google Login", for: .normal)
        }
    }
    
    @IBAction func performFBLoginButton(sender : UIButton) {
        
        if sender.tag == 2 {
            self.logoutFromFacebook()
            sender.tag = 1
            self.updateFBButtonText(sender: sender)
            self.txtView_Result.text = ""
            return
        }
        
        self.loginWithFacebook(successHandler: { (userInfo) in
            
            print("FB User Info", userInfo)
            let name : String = userInfo["name"] as! String
            let email : String = userInfo["email"] as! String
            self.txtView_Result.text = "FB Login Result:\n" + "Name : " + name + "\n" + "Email : " + email
            sender.tag = 2
            self.updateFBButtonText(sender: sender)

        }) { (error) in
            self.txtView_Result.text = "FB Login Error Result:\n" + (error as! String)
        }
    }

    func updateFBButtonText(sender : UIButton) {
        if sender.tag == 2 {
            sender.setTitle("Logout", for: .normal)
        } else {
            sender.setTitle("FB Login", for: .normal)
        }
    }

}
