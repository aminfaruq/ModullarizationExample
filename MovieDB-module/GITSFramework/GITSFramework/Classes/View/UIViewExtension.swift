//
//  UIViewExtension.swift
//  GITSFramework
//
//  Created by Ajie Pramono Arganata on 04/04/19.
//

import UIKit

public extension UIView {
    public func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius)
        layer.masksToBounds = true
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 2.0
        layer.shadowPath = shadowPath.cgPath
    }
}
