//
//  GITSRootDelegate.swift
//  GITSFramework
//
//  Created by GITS INDONESIA on 05/01/18.
//  Copyright © 2018 GITS Indonesia. All rights reserved.
//

import Foundation

public protocol GITSRootDelegate {
    func doTryAgain()
    func didRotate()
}

public extension GITSRootDelegate {
    func doTryAgain(){}
    func didRotate(){}
}
