//
//  StringValidator.swift
//  SBSwiftyBase
//
//  Created by support on 12/29/17.
//  Copyright © 2017 SANKARLAL. All rights reserved.
//

import Foundation
import UIKit

let EMAIL_CHARACTERS : String = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
let NUMERIC_CHARACTERS : Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
let DECIMAL_CHARACTERS : Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."]
let ALPHABETS_CHARACTERS : String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

extension String {
    
    //MARK: Validate String
    func isValidString() -> Bool {
        let trimedString : String = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimedString.count > 0 ? true : false
    }
    
    //MARK: Validate Email Format
    func isValidEmail() -> Bool {
        let emailTest : NSPredicate = NSPredicate(format: "SELF MATCHES %@", EMAIL_CHARACTERS)
        return emailTest.evaluate(with: self)
        
    }
    
    //MARK: Validate Numeric
    func isNumeric() -> Bool {
        let nums: Set<Character> = NUMERIC_CHARACTERS
        return Set(self).isSubset(of: nums)
    }
    
    //MARK: Validate Numeric
    func isDecimal() -> Bool {
        let nums: Set<Character> = DECIMAL_CHARACTERS
        return Set(self).isSubset(of: nums)
    }

    //MARK: Validate Alphabets
    func isAlphabets() -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: ALPHABETS_CHARACTERS).inverted
        return self.rangeOfCharacter(from: invalidCharacters, options: [], range: self.startIndex ..< self.endIndex) == nil
    }
    
    //MARK: Adding Percent Encoding
    func addingPercentEncoding() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    //MARK: Adding Symbols Encoding
    func addingSymbolsEncoding() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .symbols)!
    }

    
}
