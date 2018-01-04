//
//  SendMailController.swift
//  SBSwiftyBase
//
//  Created by support on 12/29/17.
//  Copyright © 2017 SANKARLAL. All rights reserved.
//

import Foundation
import UIKit
import MessageUI


extension UIViewController : MFMailComposeViewControllerDelegate {
    
    func sendEmail(toRecipients: [String]?, ccRecipients: [String]? = nil, bccRecipients: [String]? = nil, messageBody : String, isHTML : Bool? = false, subject: String, attachment: Data? = nil, mimeType: String? = nil, fileName: String? = nil, successHandler: @escaping SuccessHandler, failHandler: @escaping FailHandler) {
        
        if MFMailComposeViewController.canSendMail() {

            successCompletionHandler = successHandler
            failCompletionHandler = failHandler

            let mailComposeViewController = configuredMailComposeViewController(toRecipients: toRecipients,
                                                                                ccRecipients: ccRecipients,
                                                                                bccRecipients: bccRecipients,
                                                                                messageBody: messageBody,
                                                                                isHTML: isHTML,
                                                                                subject: subject,
                                                                                attachment: attachment,
                                                                                mimeType: mimeType,
                                                                                fileName: fileName)

            self.present(mailComposeViewController, animated: true, completion: nil)

        } else {
            self.showErrorAlertWithTitle("Could Not Send Email",
                                message: "Your device could not send e-mail.  Please check e-mail configuration and try again.")
        }

    }
    
    
    private func configuredMailComposeViewController(toRecipients: [String]?, ccRecipients: [String]?, bccRecipients: [String]?, messageBody : String, isHTML : Bool? = false, subject: String, attachment: Data?, mimeType: String?, fileName: String?) -> MFMailComposeViewController {
       
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(toRecipients)
        mailComposerVC.setCcRecipients(ccRecipients)
        mailComposerVC.setBccRecipients(bccRecipients)

        mailComposerVC.setSubject(subject)
        mailComposerVC.setMessageBody(messageBody, isHTML: isHTML!)
        
        // For Attachment
        if let _ = attachment {
            
            if let _ = mimeType {
                
                if let _ = fileName {
                    
                    mailComposerVC.addAttachmentData(attachment!,
                                                     mimeType: mimeType!,
                                                     fileName: fileName!)
                    
                } else {
                    self.showErrorAlertWithTitle("Missing - File Name",
                                        message: "File name is required for attachment.")

                }
            } else {
                self.showErrorAlertWithTitle("Missing - MimeType",
                                    message: "MimeType is required for attachment.")
            }
        }
        
        return mailComposerVC
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

    // MARK: MFMailComposeViewControllerDelegate Method
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result {
            
        case .cancelled :
            failCompletionHandler!("Canceled the composition." as AnyObject)
            
        case .failed :
            failCompletionHandler!("Attempt to save or send was unsuccessful." as AnyObject)

        case .saved :
            successCompletionHandler!("Successfully saved the message.." as AnyObject)

        case .sent :
            successCompletionHandler!("Successfully sent the message.." as AnyObject)

        }
        
        updateCompletionHandler()
        controller.dismiss(animated: true, completion: nil)
    }

}

