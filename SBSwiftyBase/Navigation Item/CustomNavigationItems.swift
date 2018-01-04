//
//  CustomNavigationItems.swift
//  SBSwiftyBase
//
//  Created by support on 12/29/17.
//  Copyright © 2017 SANKARLAL. All rights reserved.
//

import UIKit

/**
 CustomNavigationItems Model Class create the Left and Right Bar Button Items.
 */

class CustomNavigationItems: NSObject {

    /**
     Creates Left and Right Bar Button Items along with Images
     - Parameters:
        - leftImageNames: Pass the Array of left Bar Button Image Names
        - leftActionNames: Pass the Array of left Bar Button Action Names
        - rightImageNames: Pass the Array of right Bar Button Image Names
        - rightActionNames: Pass the Array of right Bar Button Action Names
        - title: Pass the Title Name of the class
     */

    class func navigationButtonsWithImages(leftImageNames : [String]? = [], leftActionNames : [String]? = [], rightImageNames : [String]? = [], rightActionNames : [String]? = [], title : String? = "") {
        
        let viewController : UIViewController? = topMostController()!
        
        guard viewController != nil else {
            return
        }
        
        let navItem : UINavigationItem = viewController!.navigationItem
        navItem.title = title
        
        var array_leftBarButtons : [AnyObject] = []
        var array_rightBarButtons : [AnyObject] = []

        for (leftImage, leftAction) in zip(leftImageNames!, leftActionNames!) {
           
            let leftBarButton : UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: leftImage),
                                                                       style: .plain,
                                                                       target: viewController,
                                                                       action: Selector(leftAction))
            array_leftBarButtons.append(leftBarButton)

        }
        
        for (rightImage, rightAction) in zip(rightImageNames!, rightActionNames!) {
            
            let rightBarButton : UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: rightImage),
                                                                        style: .plain,
                                                                        target: viewController,
                                                                        action: Selector(rightAction))
            array_rightBarButtons.append(rightBarButton)

        }

        navItem.leftBarButtonItems = array_leftBarButtons as? [UIBarButtonItem]
        navItem.rightBarButtonItems = array_rightBarButtons as? [UIBarButtonItem]

    }
    
    /**
     Creates Left and Right Bar Button Items along with Titles
     - Parameters:
        - leftTitleNames: Pass the Array of left Bar Button Title Names
        - leftActionNames: Pass the Array of left Bar Button Action Names
        - rightTitleNames: Pass the Array of right Bar Button Title Names
        - rightActionNames: Pass the Array of right Bar Button Action Names
        - title: Pass the Title Name of the class
 */
    
    class func navigationButtonsWithTitles(leftTitleNames : [String]? = nil, leftActionNames : [String]? = nil, rightTitleNames : [String]? = nil, rightActionNames : [String]? = nil, title : String? = "") {
        
        let viewController : UIViewController? = topMostController()!
        
        guard viewController != nil else {
            return
        }
        
        let navItem : UINavigationItem = viewController!.navigationItem
        navItem.title = title
        
        var array_leftBarButtons : [AnyObject] = []
        var array_rightBarButtons : [AnyObject] = []
        
        if let _ = leftTitleNames, let _ = leftActionNames {
            for (leftTitle, leftAction) in zip(leftTitleNames!, leftActionNames!) {
                
                let leftBarButton : UIBarButtonItem = UIBarButtonItem.init(title: leftTitle,
                                                                           style: .plain,
                                                                           target: viewController,
                                                                           action: Selector(leftAction))
                array_leftBarButtons.append(leftBarButton)
                
            }
            

        }
        if let _ = rightTitleNames, let _ = rightActionNames {
            for (rightTitle, rightAction) in zip(rightTitleNames!, rightActionNames!) {
                
                let rightBarButton : UIBarButtonItem = UIBarButtonItem.init(title: rightTitle,
                                                                            style: .plain,
                                                                            target: viewController,
                                                                            action: Selector(rightAction))
                array_rightBarButtons.append(rightBarButton)
                
            }
        }
        
        navItem.leftBarButtonItems = array_leftBarButtons as? [UIBarButtonItem]
        navItem.rightBarButtonItems = array_rightBarButtons as? [UIBarButtonItem]

    }
}
