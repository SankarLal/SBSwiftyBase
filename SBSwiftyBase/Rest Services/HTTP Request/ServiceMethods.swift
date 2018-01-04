//
//  ServiceMethods.swift
//  SBSwiftyBase
//
//  Created by support on 12/29/17.
//  Copyright © 2017 SANKARLAL. All rights reserved.
//

import Foundation
import Alamofire

typealias responseHandler = (DataResponse<Any>) -> Void

/**
 
 ServiceMethods Class manage the all Web servie methods stuff.
 */

class ServiceMethods {
    
    static func getHeaders() -> [String : String] {
        
        let header : [String : String] = ["Content-Type" : "application/json"]
        return header
        
    }
    
    static func makeGETCall(urlString : String, parameters: [String : AnyObject]? = nil, completionHandler : @escaping responseHandler, errorHandler: responseHandler? = nil) {
        print("urlString", urlString)

        let percentageURL : String = urlString.addingPercentEncoding()
        Alamofire.request(percentageURL, parameters: parameters)
            .responseJSON(completionHandler: { response in
                
                print("Response : " ,response.result.value ?? "", "\nStatus Code : " , response.response?.statusCode ?? 0)

                switch response.result {
                    
                case .success( _):
                    
                    if (response.response?.statusCode)! == 201 || response.response?.statusCode == 200 {
                        completionHandler(response)
                    } else {
                        if(errorHandler == nil) {
                            self.setupErrorMessage(response.result.value as? [String : Any])
                        } else {
                            errorHandler!(response)
                        }
                    }
                    
                case .failure(let error):
                    
                    if(errorHandler != nil) {
                        errorHandler!(response)
                    }
                    self.showErrorAlert( "Alert!",
                                        message: error.localizedDescription)
                }

            })
    }
    
    static func makePOSTCall(urlString : String, parameters: [String : AnyObject]? = nil, headers : [String : String]? = nil, completionHandler : @escaping responseHandler, errorHandler: responseHandler? = nil) {
        
        var urlHeaders : [String : String] = [String : String]()
        if let _ = headers {
            urlHeaders = headers!
        } else {
            urlHeaders = getHeaders()
        }

        print("Headers", urlHeaders)
        print("urlString", urlString)
        print("parameters", parameters ?? "")

        let percentageURL : String = urlString.addingPercentEncoding()

        Alamofire.request(percentageURL,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: urlHeaders)
            .responseJSON(completionHandler: { response in
                
                print("Response : " ,response.result.value ?? "", "\nStatus Code : " , response.response?.statusCode ?? 0)

                switch response.result {
                    
                case .success( _):
                    
                    if (response.response?.statusCode)! == 201 || response.response?.statusCode == 200 {
                        completionHandler(response)
                    } else {
                        
                        if(errorHandler == nil) {
                            self.setupErrorMessage(response.result.value as? [String : Any])
                        } else {
                            errorHandler!(response)
                        }
                    }
                    
                case .failure(let error):
                    self.showErrorAlert( "Alert!",
                                         message: error.localizedDescription)
                }
            })
    }
    
    static func makePUTCall(urlString : String, parameters: [String : AnyObject]? = nil, completionHandler : @escaping responseHandler, errorHandler: responseHandler? = nil) {
        
        print("Headers", getHeaders())
        print("urlString", urlString)
        print("parameters", parameters ?? "")
        
        let percentageURL : String = urlString.addingPercentEncoding()

        Alamofire.request(percentageURL,
                          method: .put,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: getHeaders())
            .responseJSON(completionHandler: { response in
                
                print("Response : " ,response.result.value ?? "", "\nStatus Code : " , response.response?.statusCode ?? 0)

                switch response.result {
                    
                case .success( _):
                    
                    if (response.response?.statusCode)! == 201 || response.response?.statusCode == 200 {
                        completionHandler(response)
                    } else {
                        if(errorHandler == nil) {
                            self.setupErrorMessage(response.result.value as? [String : Any])
                        } else {
                            errorHandler!(response)
                        }
                    }
                    
                case .failure(let error):
                    
                    self.showErrorAlert( "Alert!",
                                         message: error.localizedDescription)
                }
            })
    }
    
    static func makeDELETECall(urlString : String, parameters: [String : AnyObject]? = nil, completionHandler : @escaping responseHandler, errorHandler: responseHandler? = nil) {
        
        print("Headers", getHeaders())
        print("urlString", urlString)
        print("parameters", parameters!)
        
        let percentageURL : String = urlString.addingPercentEncoding()

        Alamofire.request(percentageURL,
                          method: .delete,
                          parameters: parameters,
                          encoding: JSONEncoding.prettyPrinted,
                          headers: getHeaders())
            .responseJSON(completionHandler: { response in
                
                print("Response : " ,response.result.value ?? "", "\nStatus Code : " , response.response?.statusCode ?? 0)

                switch response.result {
                    
                case .success( _):
                    
                    if (response.response?.statusCode)! == 201 || response.response?.statusCode == 200 {
                        completionHandler(response)
                    } else {
                        if(errorHandler == nil) {
                            self.setupErrorMessage(response.result.value as? [String : Any])
                        } else {
                            errorHandler!(response)
                        }
                    }
                    
                case .failure(let error):
                    
                    self.showErrorAlert( "Alert!",
                                         message: error.localizedDescription)
                }
            })
    }
    
    static func setupErrorMessage(_ response : [String : Any]?) {
        
        guard response != nil else {
            return
        }
        
        let errorMessage : String? = response!["message"]  as? String
        self.showErrorAlert("Alert!",
                            message: errorMessage ?? "Unable to fetch the data")
        
    }

    static func showErrorAlert(_ title : String, message : String) {
        
        topMostController()?.showAlertWithTitle(title,
                                               message: message,
                                               actionTitles: ["Ok"],
                                               actionCompletionHandler: { result in                                                
        })
        
    }
    
}
