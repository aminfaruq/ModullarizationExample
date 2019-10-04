//
//  AppSnackbarController.swift
//  SellOn
//
//  Created by Ajie Pramono Arganata on 25/03/19.
//  Copyright © 2019 GITS Indonesia. All rights reserved.
//

import UIKit
import Material

public class AppSnackbarController: SnackbarController {
    open override func prepare() {
        super.prepare()
        delegate = self
    }
}

extension AppSnackbarController: SnackbarControllerDelegate {
    public func snackbarController(snackbarController: SnackbarController, willShow snackbar: Snackbar) {
        print("snackbarController will show")
    }
    
    public func snackbarController(snackbarController: SnackbarController, willHide snackbar: Snackbar) {
        print("snackbarController will hide")
    }
    
    public func snackbarController(snackbarController: SnackbarController, didShow snackbar: Snackbar) {
        print("snackbarController did show")
    }
    
    public func snackbarController(snackbarController: SnackbarController, didHide snackbar: Snackbar) {
        print("snackbarController did hide")
    }
}
