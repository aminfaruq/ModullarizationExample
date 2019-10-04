//
//  ViewExtension.swift
//  GITSFramework
//
//  Created by GITS INDONESIA on 4/12/17.
//  Copyright © 2017 GITS Indonesia. All rights reserved.
//

import UIKit

public class UIHelper {
    public static func toast(message:String,vc:UIViewController){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertControllerStyle.alert)
        vc.present(alert, animated: true, completion: nil)
        let duration:TimeInterval = 1; // duration in seconds
        let time = DispatchTime.now().uptimeNanoseconds
        let tes = UInt64(duration * Double(NSEC_PER_SEC))
        let jum = time + tes
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.init(uptimeNanoseconds: jum)) {
            vc.dismiss(animated: true, completion: nil)
        }
        
    }
}
