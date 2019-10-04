//
//  ViewController.swift
//  GITSFrameworkApps
//
//  Created by GITS Indonesia on 3/15/17.
//  Copyright © 2017 GITS Indonesia. All rights reserved.
//

import UIKit
import GITSFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("url : "+GITSApps.GetUrl())
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

