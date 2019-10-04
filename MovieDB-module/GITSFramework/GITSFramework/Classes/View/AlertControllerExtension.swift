//
//  AlertControllerExtension.swift
//  GITSFramework
//
//  Created by GITS INDONESIA on 4/13/17.
//  Copyright © 2017 GITS Indonesia. All rights reserved.
//

import UIKit

public typealias alertAction = (UIAlertAction) -> Void

extension UIAlertController {
    public static func dialog(style: UIAlertControllerStyle, title: String?, message: String?, actions: [UIAlertAction], view: UIView)-> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions {
            alert.addAction(action)
        }
        if let popoverController = alert.popoverPresentationController, style == .actionSheet {
            popoverController.sourceView = view
            popoverController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        return alert
    }
}
