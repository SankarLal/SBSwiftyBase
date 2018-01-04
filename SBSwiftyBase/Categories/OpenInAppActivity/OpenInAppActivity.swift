//
//  OpenInAppActivity.swift
//  SBSwiftyBase
//
//  Created by support on 12/29/17.
//  Copyright © 2017 SANKARLAL. All rights reserved.
//

import Foundation
import UIKit

var documentInteractoinController : UIDocumentInteractionController!

extension UIViewController {
    
    func openActivityController(activityItems : [Any], excludedActivityTypes : [UIActivityType]? = nil, sourceView: UIView? = topMostController()?.view) {
        
        let activityViewController = UIActivityViewController.init(activityItems:activityItems, applicationActivities: nil)
        activityViewController.excludedActivityTypes = excludedActivityTypes
        activityViewController.popoverPresentationController?.sourceView = sourceView
        navigationController?.present(activityViewController, animated: true, completion: nil)

    }
    
    func openDocumentInteractionController(fileURL : URL) {
        
        documentInteractoinController = UIDocumentInteractionController.init(url: fileURL)
        documentInteractoinController.delegate = self
        let didShow : Bool = documentInteractoinController.presentOptionsMenu(from: self.view.bounds,
                                                                              in: self.view,
                                                                              animated: true)
        
        if didShow {
            
            print("SUCCESS")
            
        } else {
            print("NO APPS")
        }
        
    }
}


extension UIViewController : UIDocumentInteractionControllerDelegate {
    
    public func documentInteractionControllerDidEndPreview(_ controller: UIDocumentInteractionController) {
        
    }
    
    public func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
    public func documentInteractionControllerViewForPreview(_ controller: UIDocumentInteractionController) -> UIView? {
        return self.view
    }
    
    public func documentInteractionControllerRectForPreview(_ controller: UIDocumentInteractionController) -> CGRect {
        return self.view.frame
    }
    

}
