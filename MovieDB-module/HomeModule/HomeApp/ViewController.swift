//
//  ViewController.swift
//  HomeApp
//
//  Created by Amin faruq on 25/09/19.
//  Copyright © 2019 Amin faruq. All rights reserved.
//

import UIKit
import HomeModule

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        HomeWireframe.performToNotification(caller: self)
    }


}

