//
//  CardView.swift
//  GITSFramework
//
//  Created by GITS INDONESIA on 14/01/18.
//  Copyright © 2018 GITS Indonesia. All rights reserved.
//

import UIKit

public class CardView: UIView {
    @IBInspectable var radius: CGFloat = 1 //default
    @IBInspectable var shadow: CGFloat = 1 //default
    @IBInspectable var shadowRadius: CGFloat = 2.0
    @IBInspectable var borderWidth: CGFloat = 0 //default border widht
//    @IBInspectable var borderColor: UIColor = UIColor.clear //default border color
    
    override public func layoutSubviews() {
        layer.cornerRadius = radius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius)
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: shadow)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = shadowRadius
        layer.shadowPath = shadowPath.cgPath
        layer.borderWidth = borderWidth
//        layer.borderColor = borderColor.cgColor
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    public func reload() {
        setNeedsDisplay()
        layer.displayIfNeeded()
    }
}
