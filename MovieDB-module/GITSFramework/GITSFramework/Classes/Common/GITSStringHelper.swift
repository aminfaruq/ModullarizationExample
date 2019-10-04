//
//  StringHelper.swift
//  GITSFramework
//
//  Created by GITS INDONESIA on 11/24/17.
//  Copyright © 2017 GITS Indonesia. All rights reserved.
//

import Foundation

public class GITSStringHelper {
    
    public static func generateDeviceID()->String{
        //device id
        let deviceid = UIDevice.current.identifierForVendor?.uuidString
        return deviceid!
    }
    
    public static func isNotEmptyString(text: String)-> Bool {
        var status = true
        trimCharEmpty(text: text) { (trim) in
            let result = trim.components(separatedBy: " ")
            if result.count > 0 {
                for word in result {
                    if word.isEmpty {
                        status = false
                    }
                    if word != "" {
                        status = true
                    }
                }
            } else {
                status = false
            }
        }
        return status
    }
    
    public static func trimCharEmpty(text: String, onSuccess: @escaping (_ result: String)-> Void) {
        if text.first == " " {
            var truncated = text
            truncated.removeFirst()
            self.trimCharEmpty(text: truncated, onSuccess: onSuccess)
        } else if text.last == " " {
            var truncated = text
            truncated.removeLast()
            self.trimCharEmpty(text: truncated, onSuccess: onSuccess)
        } else {
            onSuccess(text)
        }
    }
    
    public static func currencyInputFormatting(text:String) -> String {
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 0
        formatter.currencySymbol = "$"
        formatter.numberStyle = .currencyAccounting
        
        var amountWithPrefix = text
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9.]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, text.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 1))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: double as NSNumber)!
    }
    
    public static func isValidEmail(text:String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: text, options: [], range: NSRange(location: 0, length: text.count)) != nil
    }
    
    public static func isValidPhoneNumber(phoneNumber: String) -> Bool {
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = phoneNumber.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  phoneNumber == filtered
    }
    
    public static func isOnlyNumber(text: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        return text.rangeOfCharacter(from: invalidCharacters) == nil
    }
    
    
    public static func isValidPassword(text: String) -> (Bool, Bool, Bool) {
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        let capitalresult = texttest.evaluate(with: text)
        
        let lowerLetterRegEx  = ".*[a-z]+.*"
        let texttest2 = NSPredicate(format:"SELF MATCHES %@", lowerLetterRegEx)
        let lowerresult = texttest2.evaluate(with: text)
        
        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let numberresult = texttest1.evaluate(with: text)
        
        return (capitalresult, lowerresult, numberresult)
        
    }
    
    public static func localized(key: String, bundle: Bundle) -> String {
        return NSLocalizedString(key, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}

extension String {
    
    public var localized: String {
        if GITSPref.getString(key: GITSPref.KEY_LANGUAGE) == "" {
            // we set a default, just in case
            GITSPref.saveString(key: GITSPref.KEY_LANGUAGE, value: "id")
        }
        else {}
        
        let lang = GITSPref.getString(key: GITSPref.KEY_LANGUAGE)
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path ?? "")
        return NSLocalizedString(self, tableName: nil, bundle: bundle ?? Bundle(), value: "", comment: "")
    }
    
    public func htmlLinkDetector() -> String {
        var resultText = self
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count))
        
        for match in matches {
            guard let range = Range(match.range, in: self) else { continue }
            let url = self[range]
            resultText = resultText.replacingOccurrences(of: url, with: "<a href=\"\(url)\">\(url)</a>", options: .literal, range: nil)
        }
        return resultText
    }
    
    public func validateUrl() -> String {
        if self.contains("http://") || self.contains("https://") {
            return self
        } else {
            return "http://\(self)"
        }
    }
    
    
    public var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    public var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
