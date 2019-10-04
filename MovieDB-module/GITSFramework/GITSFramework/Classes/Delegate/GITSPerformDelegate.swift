//
//  GITSRootPerformDelegate.swift
//  GITSFramework
//
//  Created by Tri Rejeki on 30/01/18.
//  Copyright © 2018 GITS Indonesia. All rights reserved.
//

import Foundation

public protocol GITSPerformDelegate {
    func doInitSplash(perform: GITSPerformDelegate?, data: [String: Any?])-> UIViewController
    func doInitHome(perform: GITSPerformDelegate?, data: [String: Any?])-> UIViewController
    func doInitActivities(perform: GITSPerformDelegate?, data: [String: Any?])-> UIViewController
    func doInitAbsent(caller : UIViewController, perform: GITSPerformDelegate?, data: [String: Any?])
    func doChangeRootViewController(vc: UIViewController)
    func doCallStartBluetooth()
    func doCheckWifi()
    func doInitNewReservation(caller : UIViewController, perform: GITSPerformDelegate?, data: [String: Any?])
    func doInitNewsList(caller : UIViewController, perform: GITSPerformDelegate?, data: [String: Any?])
    func doInitNewsDetail(caller : UIViewController, perform: GITSPerformDelegate?, data: [String: Any?])
    func doInitProfile(perform: GITSPerformDelegate?, data: [String: Any?]) -> UIViewController
    //
    func doInitNotification(perform: GITSPerformDelegate?, data: [String: Any?]) -> UIViewController
    func doInitLogin(perform: GITSPerformDelegate?, data: [String: Any?]) -> UIViewController
    func doInitFinishSplash()
    func doInitTimeOff(caller : UIViewController, perform: GITSPerformDelegate?, data: [String: Any?])
    func doPresentReservationDetail(caller : UIViewController, perform: GITSPerformDelegate?, id: Int)
}

public protocol GITSPerformOutputDelegate {
    func changeRootViewController(vc: UIViewController)
    func doResultCallStart()
    func doResultCheckWifi()
    func doFinishSplash()
}
