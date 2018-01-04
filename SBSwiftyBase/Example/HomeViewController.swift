//
//  HomeViewController.swift
//  SBSwiftyBase
//
//  Created by support on 12/29/17.
//  Copyright © 2017 SANKARLAL. All rights reserved.
//

import UIKit

enum HomeNavigationType : String {
    case navigationBarItem = "Navigation Bar Item"
    case socialMediaLogin = "Social Media Login"
    case storage = "Storages"
    case qrCodeScanner = "QRCode Scanner"
    case webServices = "WebServices"
    case others = "Others"
}

class HomeViewController: UIViewController {

    @IBOutlet weak var tblView_Home : UITableView!
    var array_Home : [HomeNavigationType] = [HomeNavigationType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUserInterface()
        
    }

    func setUpUserInterface() {
        
        array_Home.append(.navigationBarItem)
        array_Home.append(.socialMediaLogin)
        array_Home.append(.storage)
        array_Home.append(.qrCodeScanner)
        array_Home.append(.webServices)
        array_Home.append(.others)

        tblView_Home.separatorStyle = .singleLine
        tblView_Home.separatorColor = UIColor.black
        tblView_Home.tableFooterView = UIView()
        tblView_Home.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Home_Cell")
        
        self.title = "Home"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array_Home.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Home_Cell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = array_Home[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var pushCtrl : UIViewController = UIViewController()
        
        switch array_Home[indexPath.row] {
            
        case .navigationBarItem:
            
            pushCtrl = self.storyboard?.instantiateViewController(withIdentifier: SB_NAVIGATION_BAR_ITEM_ID) as! NavigationBarItemViewController
            
        case .socialMediaLogin:
                pushCtrl = self.storyboard?.instantiateViewController(withIdentifier: SB_SOCIAL_MEDIA_LOGIN_ID) as! SocialMediaLoginViewController

        case .storage:
            pushCtrl = self.storyboard?.instantiateViewController(withIdentifier: SB_STORAGE_ID) as! StorageViewController
            
        case .qrCodeScanner:
            pushCtrl = self.storyboard?.instantiateViewController(withIdentifier: SB_QRCODE_SCANNER_ID) as! QRScannerController
            (pushCtrl as! QRScannerController).delegate = self
            
        case .webServices:
            pushCtrl = self.storyboard?.instantiateViewController(withIdentifier: SB_WEBSERVICES_ID) as! WebServicesViewController

        case .others:
            pushCtrl = self.storyboard?.instantiateViewController(withIdentifier: SB_OTHERS_ID) as! OthersViewController

        }
        self.navigationController?.pushViewController(pushCtrl, animated: true)
    }
}

extension HomeViewController : QRScannerDelegate {
    
    func getQRScannerValue(qrValue: String) {
        print("Scanned QRCode Value", qrValue)
    }
}
