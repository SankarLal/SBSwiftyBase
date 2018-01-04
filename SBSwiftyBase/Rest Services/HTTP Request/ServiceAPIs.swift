//
//  ServiceAPIs.swift
//  SBSwiftyBase
//
//  Created by support on 12/29/17.
//  Copyright © 2017 SANKARLAL. All rights reserved.
//

import Foundation

extension ServiceMethods {
    
    static func citiesCall(completionHandler: @escaping responseHandler)  {
       
        makeGETCall(urlString: SERVER_NAME + CITIES_SERVICE,
                     completionHandler:completionHandler)
    }
}
