//
//  OthersViewController.swift
//  SBSwiftyBase
//
//  Created by support on 12/29/17.
//  Copyright © 2017 SANKARLAL. All rights reserved.
//

import UIKit

enum OthersType : String {
    case aletView = "Show Alert View"
    case actionSheet = "Show Action Sheet"
    case sendSMS = "Send SMS/Message"
    case sendEmail = "Send E-mail"
    case stringValidator = "String Validator"
    case openActivity = "Open Activity Controller"
    case openDocumentInteraction = "Open Document Interaction Controller"
    case none
}

class OthersViewController: UIViewController {

    @IBOutlet weak var tblView_Others : UITableView!
    
    var othersType : OthersType = .none
    var array_Others : [OthersType] = [OthersType]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUserInterface()
    }

    func setUpUserInterface() {
        
        array_Others.append(.aletView)
        array_Others.append(.actionSheet)
        array_Others.append(.sendSMS)
        array_Others.append(.sendEmail)
        array_Others.append(.stringValidator)
        array_Others.append(.openActivity)
        array_Others.append(.openDocumentInteraction)

        tblView_Others.separatorStyle = .singleLine
        tblView_Others.separatorColor = UIColor.black
        tblView_Others.tableFooterView = UIView()
        tblView_Others.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Others_Cell")
        
        self.title = "Others"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension OthersViewController {
    
    func performShowAlertView() {
        
        self.showAlertWithTitle("Title",
                                message: "Text Message",
                                actionTitles: ["Ok", "Cancel"]) { (action) in
                                    if action == "Ok" {
                                        print("Ok Button Pressed")
                                    } else {
                                        print("Cancel Button Pressed")
                                    }
        }

    }
    
    func performShowActionSheet() {

        self.showActionSheetWithTitle("Action Title",
                                      message: "Sample Message",
                                      actionTitles: ["Ok"]) { (action) in
        }
    }
    
    func performSendMessage() {
        
        self.sendMessage(recipients: ["9789537536"],
                         body: "Test Body",
                         subject: "Test Subject",
                         successHandler: { successMessage in
                            print("Message Success - ", successMessage)
                            
        }) { failureMessage in
            print("Message Failure Reason - ", failureMessage)
        }
        
        /**
         OR - If 'body' or 'subject' is not required omit that param
         */
        
//        self.sendMessage(recipients: ["9789537536"],
//                         subject: "Test Subject",
//                         successHandler: { successMessage in
//                            print("Message Success - ", successMessage)
//
//        }) { failureMessage in
//            print("Message Failure Reason - ", failureMessage)
//        }

    }
    
    func performSendEMail() {
        
        self.sendEmail(toRecipients: ["sankarlal20@gmail.com"],
                       ccRecipients: nil,
                       bccRecipients: nil,
                       messageBody: "Sample Message Body Text",
                       isHTML: false,
                       subject: "Test Subject",
                       attachment: nil,
                       mimeType: nil,
                       fileName: nil,
                       successHandler: { successMessage in
                        
                        print("EMail Success - ", successMessage)
                        
        }) { failureMessage in
            
            print("EMail Failure Reason - ", failureMessage)
            
        }
        
        /**
         OR - If 'ccRecipients', 'bccRecipients', 'isHTML', 'attachment', 'mimeType' or 'fileName' is not required omit that param
         */

//        self.sendEmail(toRecipients: ["sankarlal20@gmail.com"],
//                       messageBody: "Sample Message Body Text",
//                       subject: "Test Subject",
//                       successHandler: { successMessage in
//
//                        print("EMail Success - ", successMessage)
//
//        }) { failureMessage in
//
//            print("EMail Failure Reason - ", failureMessage)
//
//        }
        
    }
    
    func performStringValidator() {
        
        let string = "StringValidator"
        
        if string.isValidString() {
            print("Valid String")
        }
        if string.isValidEmail() {
            print("Valid Email")
        }
        if string.isNumeric(){
            print("Valid Numeric")
        }
        if string.isDecimal(){
            print("Valid Decimal")
        }
        if string.isAlphabets(){
            print("Valid Alphabets")
        }

    }
    
    func performOpenActivityController() {
        
        let text = "This is some text that I want to share."
        let image = #imageLiteral(resourceName: "Left2Image")

        self.openActivityController(activityItems: [text, image])

        /**
        // OR - With Exclude Activity Types
         
        self.openActivityController(activityItems: [text, image],
                                    excludedActivityTypes: [.airDrop, .postToFacebook])

        */
        
    }
    
    func performOpenDocumentInteractionController() {

        let fileURLPath = Bundle.main.path(forResource: "iPhoneImage", ofType: "png")
        let fileURL = URL.init(fileURLWithPath: fileURLPath!)
        self.openDocumentInteractionController(fileURL: fileURL)
    }
}

extension OthersViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array_Others.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Others_Cell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = array_Others[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch array_Others[indexPath.row] {
            
        case .aletView:
            performShowAlertView()
            
        case .actionSheet:
            performShowActionSheet()
            
        case .sendSMS:
            performSendMessage()
            
        case .sendEmail:
            performSendEMail()
            
        case .stringValidator:
            performStringValidator()
            
        case .openActivity:
            performOpenActivityController()
            
        case .openDocumentInteraction:
            performOpenDocumentInteractionController()
            
        default:
            break
        }
        
    }
}

