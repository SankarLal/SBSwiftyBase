//
//  ShowAlertController.swift
//  SBSwiftyBase
//
//  Created by support on 12/29/17.
//  Copyright © 2017 SANKARLAL. All rights reserved.
//

import Foundation
import UIKit

public typealias OnActionHandler = (_ actionValue : String?) -> Void

extension UIViewController {
    
    func showAlertWithTitle(_ title : String? = "", message : String? = "", actionTitles : [String], actionStyles : [UIAlertActionStyle]? = nil, actionCompletionHandler : @escaping OnActionHandler) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        var actionStyleArray : [UIAlertActionStyle]? = actionStyles

        if actionStyleArray == nil {
            actionStyleArray = Array(repeating: UIAlertActionStyle.default, count: actionTitles.count)
        }
        
        for (actTitle, actStyle) in zip(actionTitles, actionStyleArray!) {
            alert.addAction(UIAlertAction(title: actTitle, style: actStyle, handler: { action in
                actionCompletionHandler(actTitle)
            }))
        }
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
