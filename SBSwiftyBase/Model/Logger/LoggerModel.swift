//
//  LoggerModel.swift
//  SBSwiftyBase
//
//  Created by support on 12/29/17.
//  Copyright © 2017 SANKARLAL. All rights reserved.
//

import UIKit


public enum LogLevel : String {
    case off
    case error
    case warning
    case info
    case debug
    case verbose
    case all
}

var logLevelType : LogLevel = LogLevel.all

class LoggerModel: NSObject {

    
    class func logMessage(_ message : String, type : LogLevel,
                       functionName : String = #function, fileNameWithPath : String = #file, lineNumber : Int = #line) {
        
        if logLevelType == .off || (logLevelType != type && logLevelType != .all) {
            return
        }
                
        #if DEBUG

            let fileNameWithoutPath = (fileNameWithPath as NSString).lastPathComponent

            let output = "\(type.rawValue.uppercased()) { \n Message : \(message) \n Date_Time : \(self.dateAndTime()) \n Class_Name : \(fileNameWithoutPath) \n Function_Name : \(functionName) \n Line : \(lineNumber) \n }"
            print(output)
           
        #endif

    }
    
    private class func dateAndTime() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-YY hh:mm:ss a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        let dateAndTime = dateFormatter.string(from: NSDate() as Date)
        return dateAndTime
    }
    
}


