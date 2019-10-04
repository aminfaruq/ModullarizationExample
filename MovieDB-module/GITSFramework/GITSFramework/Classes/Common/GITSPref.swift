//
//  GITSPref.swift
//  GITSFramework
//
//  Created by GITS Indonesia on 3/14/17.
//  Copyright © 2017 GITS Indonesia. All rights reserved.
//

import Foundation
import NetworkModule
import SwiftyJSON

public struct GITSPref {
    public static var KEY_LOGIN = "LOGIN"
    public static var KEY_WALKTHROUGH = "WALKTHROUGH"
    public static var KEY_GOALS = "SAVE_GOALS"
    public static var KEY_LANGUAGE = "i18n_language"
    public static var KEY_DEVICE_TOKEN = "device_token"
    public static var KEY_UPDATE_LOCATION_BLE = "UPDATE_LOCATION_BLE"
    public static var KEY_LATEST_LOCATION_BLE = "LATEST_LOCATION_BLE"
    public static var KEY_ATTENDANCE_STATUS = "ATTENDANCE_STATUS"
    public static var KEY_ATTENDANCE_WIFI = "ATTENDANCE_WIFI"
    public static var KEY_ATTENDANCE_DATA = "ATTENDANCE_DATA"
    public static var KEY_USER = "USER"
    public static var KEY_ID_USER = "ID_USER"
    public static var KEY_TOKEN = "TOKEN"
    public static var KEY_CONFIG = "CONFIG"
    
    static let pref = UserDefaults.standard
    
    public static func saveObject(key:String ,value:AnyObject){
        let data = NSKeyedArchiver.archivedData(withRootObject: value)
        pref.set(data, forKey: key)
        commit()
    }
    
    public static func saveBool(key:String,value:Bool){
        pref.set(value, forKey: key)
        commit()
    }
    
    public static func saveInt(key:String,value:Int) {
        pref.set(value, forKey: key)
        commit()
    }
    
    public static func saveString(key:String,value:String) {
        pref.set(value, forKey: key)
        commit()
    }
    
    public static func commit(){
        pref.synchronize()
    }
    
    public static func remove(key:String) {
        pref.removeObject(forKey: key)
    }
    
    public static func getObject(key:String)->AnyObject?{
        if let data = pref.object(forKey: key) as? NSData {
            let obj = NSKeyedUnarchiver.unarchiveObject(with: data as Data)!
            return obj as AnyObject?
        }
        return nil
    }
    
    public static func getString(key:String) -> String{
        if let string = pref.string(forKey: key) {
            return string
        }
        return ""
    }
    
    public static func getBool(key:String) -> Bool {
        if pref.bool(forKey: key) {
            return pref.bool(forKey: key)
        }
        return false
    }
    
    public static func getInt(key:String) -> Int {
        return pref.integer(forKey: key)
    }
    
    public static func getLogin() -> [String: String]? {
        if let result = getObject(key: KEY_LOGIN) as? [String: String] {
            return result
        }
        else {
            return nil
        }
    }
    
    public static func getGoals() -> [[String: Any?]] {
        if let result = getObject(key: KEY_GOALS) as? [[String: Any?]] {
            return result
        }else{
            return []
        }
    }
}
