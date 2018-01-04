//
//  NavigationBarItemViewController.swift
//  SBSwiftyBase
//
//  Created by support on 12/29/17.
//  Copyright © 2017 SANKARLAL. All rights reserved.
//

import UIKit

enum NavigationBarItemType : String {
    case leftBarItem = "Navigation Left Bar Item's"
    case rightBarItem = "Navigation Right Bar Item's"
    case leftRightBarItems = "Navigation Left And Right Bar Item's"
    case leftBarImage = "Navigation Left Bar Image's"
    case rightBarImage = "Navigation Right Bar Image's"
    case leftRightBarImages = "Navigation Left And Right Bar Image's"
    case none
}

class NavigationBarItemViewController: UIViewController {

    @IBOutlet weak var tblView_NavigationBarItem : UITableView!
    var navigationBarItemType : NavigationBarItemType = .none
    var array_NavigationBarItem : [NavigationBarItemType] = [NavigationBarItemType]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUserInterface()
        addLeftBarTitleItem()
    }

    func setUpUserInterface() {
        
        array_NavigationBarItem.append(.leftBarItem)
        array_NavigationBarItem.append(.rightBarItem)
        array_NavigationBarItem.append(.leftRightBarItems)
        array_NavigationBarItem.append(.leftBarImage)
        array_NavigationBarItem.append(.rightBarImage)
        array_NavigationBarItem.append(.leftRightBarImages)
        
        tblView_NavigationBarItem.separatorStyle = .singleLine
        tblView_NavigationBarItem.separatorColor = UIColor.black
        tblView_NavigationBarItem.tableFooterView = UIView()
        tblView_NavigationBarItem.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "NavigationBarItem_Cell")
    }

    // MARK: Setup Navigation Title Item
    func addRightBarTitleItem() {
        
        CustomNavigationItems.navigationButtonsWithTitles(rightTitleNames: ["Right1", "Right2"],
                                                          rightActionNames: ["performRight1BarButton", "performRight2BarButton"],
                                                          title: "Right Bar Button")

        // OR
//        CustomNavigationItems.navigationButtonsWithTitles(leftTitleNames: nil,
//                                                          leftActionNames: nil,
//                                                          rightTitleNames: ["Right1"],
//                                                          rightActionNames: ["performRight1BarButton"],
//                                                          title: "Right Bar Button")

    }

    func addLeftBarTitleItem() {
        
        CustomNavigationItems.navigationButtonsWithTitles(leftTitleNames: ["Left1", "Left2"],
                                                          leftActionNames: ["performLeft1BarButton", "performLeft2BarButton"],
                                                          title: "Left Bar Button")
        
        // OR
//        CustomNavigationItems.navigationButtonsWithTitles(leftTitleNames: ["Left1"],
//                                                          leftActionNames: ["performLeft1BarButton"],
//                                                          rightTitleNames: nil,
//                                                          rightActionNames: nil,
//                                                          title: "Left Bar Button")

    }

    func addLeftRightBarTitleItem() {
        
        CustomNavigationItems.navigationButtonsWithTitles(leftTitleNames: ["Left1"],
                                                          leftActionNames: ["performLeft1BarButton"],
                                                          rightTitleNames: ["Right1", "Right2"],
                                                          rightActionNames: ["performRight1BarButton", "performRight2BarButton"],
                                                          title: "Left And Right Bar Button")

    }

    // MARK: Setup Navigation Image Item
    func addRightBarImageItem() {
        
        CustomNavigationItems.navigationButtonsWithImages(rightImageNames: ["Right1Image", "Right2Image"],
                                                          rightActionNames: ["performRight1BarImage", "performRight2BarImage"],
                                                          title: "Right Bar Image")
        
        // OR
//        CustomNavigationItems.navigationButtonsWithImages(leftImageNames: nil,
//                                                          leftActionNames: nil,
//                                                          rightImageNames: ["Right1Image"],
//                                                          rightActionNames: ["performRight1BarImage"],
//                                                          title: "Right Bar Image")
    }
    
    func addLeftBarImageItem() {
        
        CustomNavigationItems.navigationButtonsWithImages(leftImageNames: ["Left1Image", "Left2Image"],
                                                          leftActionNames: ["performLeft1BarImage", "performLeft2BarImage"],
                                                          title: "Left Bar Image")
        // OR
//        CustomNavigationItems.navigationButtonsWithImages(leftImageNames: ["Left1Image", "Left2Image"],
//                                                          leftActionNames: ["performLeft1BarImage", "performLeft2BarImage"],
//                                                          rightImageNames: nil,
//                                                          rightActionNames: nil,
//                                                          title: "Right Bar Image")

    }
    
    func addLeftRightBarImageItem() {
        
        CustomNavigationItems.navigationButtonsWithImages(leftImageNames: ["Left1Image"],
                                                          leftActionNames: ["performLeft1BarImage"],
                                                          rightImageNames: ["Right1Image", "Right2Image"],
                                                          rightActionNames: ["performRight1BarButton", "performRight2BarButton"],
                                                          title: "Left And Right Bar Image")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension NavigationBarItemViewController {
    
    @objc func performRight1BarButton() {
        print("performRight1BarButton")
    }
    
    @objc func performRight2BarButton() {
        print("performRight2BarButton")
    }
    
    @objc func performLeft1BarButton() {
        print("performLeft1BarButton")
    }
    
    @objc func performLeft2BarButton() {
        print("performLeft2BarButton")
    }
    
    @objc func performRight1BarImage() {
        print("performRight1BarImage")
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func performRight2BarImage() {
        print("performRight2BarImage")
    }
    
    @objc func performLeft1BarImage() {
        print("performLeft1BarImage")
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func performLeft2BarImage() {
        print("performLeft2BarImage")
    }

}

extension NavigationBarItemViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array_NavigationBarItem.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "NavigationBarItem_Cell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = array_NavigationBarItem[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch array_NavigationBarItem[indexPath.row] {

        case .leftBarItem:
            self.addLeftBarTitleItem()
            
        case .rightBarItem:
            self.addRightBarTitleItem()
            
        case .leftRightBarItems:
            self.addLeftRightBarTitleItem()
            
        case .leftBarImage:
            self.addLeftBarImageItem()
            
        case .rightBarImage:
            self.addRightBarImageItem()
            
        case .leftRightBarImages:
            self.addLeftRightBarImageItem()
            
        default:
            break
        }
        
    }
}

