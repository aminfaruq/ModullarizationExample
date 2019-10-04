//
//  AppUtility.swift
//  Alamofire
//
//  Created by Ajie Pramono Arganata on 10/10/18.
//

import Foundation

public struct AppUtility {
    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    public static func lockOrientation(_ rotateOrientation: UIInterfaceOrientation) {
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
    }
    
    public static func printFutureValue(amount: Double, totalMonth month: Double) -> Double {
        var loop: Double = (month / 12) / 3
        loop.round(FloatingPointRoundingRule.up)
        if loop > 5 {
            loop = 5 //max looping
        }
        var rate: Double = 0.03 + (0.01 * loop)
        var futureValue_: Double = 0
        
        for index in 0..<Int(loop) {
            if index == 0 {
                futureValue_ = futureValue(rate: rate / 12, nper: month - Double(((Int(loop) - 1) * 36)), pmt: amount)
            }
            else {
                futureValue_ = futureValue(rate: rate / 12, nper: 36, pmt: amount, pv: futureValue_)
            }
            rate -= 0.01
        }
        return (futureValue_)

    }
    
    public static func futureValue(rate: Double, nper: Double, pmt: Double, pv: Double = 0, type: Double = 1)-> Double {
        // nper: n-period | total periode
        // pmt : payment | angsuran
        // pv  : present value
        let final = pmt * (1 + rate * type) * ((1 - pow((1 + rate), nper)) / rate) - (pv * pow((1 + rate), nper))
        return -final
    }
}
