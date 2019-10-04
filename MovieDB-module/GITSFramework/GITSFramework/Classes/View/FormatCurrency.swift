//
//  FormatCurrency.swift
//  GITSSubServiceDetail
//
//  Created by IRFAN TRIHANDOKO on 4/19/17.
//  Copyright © 2017 IRFAN TRIHANDOKO. All rights reserved.
//

import Foundation

extension Double {
    public func toRupiah() -> String{
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencySymbol = "Rp "
        currencyFormatter.locale = NSLocale(localeIdentifier: "id_ID") as Locale
        return currencyFormatter.string(from: self as NSNumber)!
    }
    
    public func toDollar() -> String{
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencySymbol = "$ "
        currencyFormatter.locale = NSLocale(localeIdentifier: "en_US") as Locale
        return currencyFormatter.string(from: self as NSNumber)!
    }
    
    public var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.1f", self)
    }
}

extension String {
    // formatting text for currency textField
    public func currencyInputFormatting() -> String {
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        formatter.locale = NSLocale(localeIdentifier: "id_ID") as Locale
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
}
