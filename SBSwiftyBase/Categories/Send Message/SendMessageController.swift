//
//  SendMessageController.swift
//  SBSwiftyBase
//
//  Created by support on 12/29/17.
//  Copyright © 2017 SANKARLAL. All rights reserved.
//

import Foundation
import UIKit
import MessageUI


extension UIViewController : MFMessageComposeViewControllerDelegate {
    
    func sendMessage(recipients: [String]?, body: String? = nil, subject: String? = nil, successHandler: @escaping SuccessHandler, failHandler: @escaping FailHandler) {
        
        if (MFMessageComposeViewController.canSendText()) {
           
            successCompletionHandler = successHandler
            failCompletionHandler = failHandler

            let messageComposeViewController = configuredMessageComposeViewController(recipients: recipients,
                                                                                      body: body,
                                                                                      subject: subject)
            self.present(messageComposeViewController, animated: true, completion: nil)

        } else {
            self.showErrorAlertWithTitle("Could Not Send Message",
                                message: "Your device could not send message. Please check message configuration and try again.")
        }
    }
    
    private func configuredMessageComposeViewController(recipients: [String]?, body: String?, subject: String?) ->
        MFMessageComposeViewController {
            
            let messageComposerVC = MFMessageComposeViewController()
            messageComposerVC.recipients = recipients
            messageComposerVC.body = body
            messageComposerVC.subject = subject
            messageComposerVC.messageComposeDelegate = self
            return  messageComposerVC
    }
    
    private func showErrorAlertWithTitle(_ title : String, message : String) {
        
        updateCompletionHandler()
        
        self.showAlertWithTitle(title,
                                message: message,
                                actionTitles: ["Ok"],
                                actionCompletionHandler: { result in
                                    
        })
        
    }
    
    private func updateCompletionHandler() {
        successCompletionHandler = nil
        failCompletionHandler = nil
    }
    
    // MARK: MFMessageComposeViewControllerDelegate Method
    public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        switch result {
            
        case .cancelled :
            failCompletionHandler!("Canceled the composition." as AnyObject)
            
        case .failed :
            failCompletionHandler!("Attempt to save or send was unsuccessful." as AnyObject)
                        
        case .sent :
            successCompletionHandler!("Successfully sent the message.." as AnyObject)
            
        }
        
        updateCompletionHandler()

        controller.dismiss(animated: true, completion: nil)
    }
    
}
