//
//  WebServicesViewController.swift
//  SBSwiftyBase
//
//  Created by support on 12/29/17.
//  Copyright © 2017 SANKARLAL. All rights reserved.
//

import UIKit

class WebServicesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Web Services"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension WebServicesViewController {
    
    @IBAction func performGetCitiesButton() {
        
        ServiceMethods.citiesCall { (response) in
            print("RESPONSE", response.result.value ?? "NO VALUE")
        }
    }
}
