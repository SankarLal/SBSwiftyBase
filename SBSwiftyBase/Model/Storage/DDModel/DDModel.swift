//
//  DDModel.swift
//  SBSwiftyBase
//
//  Created by support on 12/29/17.
//  Copyright © 2017 SANKARLAL. All rights reserved.
//

import UIKit
import Foundation

/**
 DDModel (Document Directory Model) class helps to save Values or Datas into Document Directory path.
 - Values: May be Array, Dictionary, Array of Dictionary, Dictionary of Array, Object Classes.
 - Data: May be Image, Video, Audio, PDF etc.
 */

class DDModel: NSObject {

    /**
     Store Array, Array of Dictionary into Document Directory
     - Parameters:
        - dataArray: Pass Array values
        - cacheName: Store the Array values given by Cache Name
     
     - Returns:
        - Success: If values are stored successfully, it returns success as boolean.
        - Failure: If values are not stored, it return falire as boolean.
 */
    
    class func addUpdateCacheWithArray(_ dataArray : [Any], inNamedCache cacheName: String) -> Bool {
      
        var temp : [Any] = getArrayFromNamedCache(cacheName)
        temp.append(contentsOf: dataArray)
        
        return writeArrayToDD(temp, inNamedCache: cacheName)
        
    }
    
    class func addUpdateCacheWithDictionary(_ dataDict : [String : Any], inNamedCache cacheName: String) -> Bool {
        return writeDictionaryToDD(dataDict, inNamedCache: cacheName)
        
    }
    
    class func addCacheWithData(_ data : Data, inNamedCache cacheName: String) -> Bool {
        return writeDataToDD(data, inNamedCache: cacheName)
    }
    
    class func savePlistData(_ data : Any, inNamedCache cacheName: String, dataKey : String) -> Bool {
        
        let plistStaus = setUpPlistFileInNamedCache(cacheName)
       
        guard plistStaus.status else {
            print("SETUP PLIST STATUS MESSAGE", plistStaus.message)
            return false
        }
        
        let filePath = getPathForNamedCache(cacheName)

        let dict : NSMutableDictionary = [:]
        dict.setObject(data, forKey: dataKey as NSCopying)
        return dict.write(toFile: filePath, atomically: false)
        
    }
    
    class func getPlistDataFromNamedCache(_ cacheName: String, dataKey : String?) -> Any? {
        
        let filePath = getPathForNamedCache(cacheName)
        if FileManager.default.fileExists(atPath: filePath) {
            if let key = dataKey {
                return NSMutableDictionary.init(contentsOfFile: filePath)?.value(forKey: key)
            } else {
                return NSMutableDictionary.init(contentsOfFile: filePath)
            }
            
        } else {
            return nil
        }
    }

    class func getAllPDFFiles() -> NSArray {
        
        let filelist : NSArray = try! FileManager.default.subpathsOfDirectory(atPath: getdocumentsDirectory()) as NSArray
        let extensions :  NSArray = NSArray.init(objects: "pdf", "PDF")
        let fileListArray : NSArray = filelist.filtered(using: NSPredicate.init(format: "pathExtension IN %@", extensions)) as NSArray
        
        return fileListArray

    }
    
    class func getArrayFromNamedCache(_ cacheName : String) -> [Any] {
        
        let filePath = getPathForNamedCache(cacheName)
        if FileManager.default.fileExists(atPath: filePath) {
            return NSArray.init(contentsOfFile: filePath) as! [Any]
        } else {
            return [Any]()
        }
    }
    
    class func getDictionaryFromNamedCache(_ cacheName : String) -> [String : Any] {
        
        let filePath = getPathForNamedCache(cacheName)
        if FileManager.default.fileExists(atPath: filePath) {
            return NSMutableDictionary.init(contentsOfFile: filePath) as! [String : Any]
        } else {
            return [:]
        }
    }

    
    class func getDataFromNamedCache(_ cacheName : String) -> URL? {
        
        let filePath = getPathForNamedCache(cacheName)
        if FileManager.default.fileExists(atPath: filePath) {
            return NSURL.fileURL(withPath: filePath)
        } else {
            return nil
        }
    }

    
    class func deleteCacheName(_ cacheName : String) -> Bool {
        
        let filePath = getPathForNamedCache(cacheName)
        
        if FileManager.default.fileExists(atPath: filePath) {
            
            do {
                try FileManager.default.removeItem(atPath: filePath)
                return true
            } catch {
            }
        }
        
        return false
    }

    private class func setUpPlistFileInNamedCache(_ cacheName : String) -> (status : Bool, message : String) {
        
        let filePath = getPathForNamedCache(cacheName)
        let fileManager  = FileManager.default
        
        if !fileManager.fileExists(atPath: filePath) {
            
            if let bundlePath = Bundle.main.path(forResource: cacheName, ofType: "plist") {
                
                do {
                    try fileManager.copyItem(atPath: bundlePath, toPath: filePath)
                    
                } catch {
                    return (false, "Copy Failed")
                }
            } else {
                return (false, "File" + cacheName + ".plist is not found")
            }
        } else {
            return (true , "File" + cacheName + ".plist is already exits")
        }
        
        return (true, "Success")
    }
    
    private class func writeArrayToDD(_ dataArray : [Any], inNamedCache cacheName: String) -> Bool {
        
        let filePath = getPathForNamedCache(cacheName)
        return (dataArray as NSArray).write(toFile: filePath, atomically: true)

    }

    private class func writeDictionaryToDD(_ dataDictionary : [String : Any], inNamedCache cacheName: String) -> Bool {
        
        let filePath = getPathForNamedCache(cacheName)
        return (dataDictionary as NSDictionary).write(toFile: filePath, atomically: false)
        
    }

    private class func writeDataToDD(_ data : Data, inNamedCache cacheName: String) -> Bool {
        
        let filePath = getPathForNamedCache(cacheName)
        return (data as NSData).write(toFile: filePath, atomically: true)
        
    }
    class func getPathForNamedCache(_ cacheName : String) -> String {
        
        let filePath = (getdocumentsDirectory() as NSString).appendingPathComponent(cacheName)
        return filePath
        
    }
    
    private class func getdocumentsDirectory() -> String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

    }
}

