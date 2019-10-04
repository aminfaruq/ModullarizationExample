//
//  CustomProgressView.swift
//  Alamofire
//
//  Created by Ajie Pramono Arganata on 11/09/18.
//

import Foundation

open class CustomProgressView: UIProgressView {
    @IBInspectable var height: CGFloat {
        get {
            return self.height
        } set {
            self.transform = self.transform.scaledBy(x: 0, y: newValue)
        }
    }
}
