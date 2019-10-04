//
//  TriangleView.swift
//  GITSFramework
//
//  Created by Ajie Pramono Arganata on 28/05/18.
//  Copyright © 2018 GITS Indonesia. All rights reserved.
//

import UIKit

public class TriangleView : UIView {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(UIColor.white.cgColor)
        context.fill(rect)
        
        let trianglePath = UIBezierPath()
        // First move to the Top point
        trianglePath.move(to: CGPoint(x: self.bounds.width/2, y: 0.0))
        // Add line to Bottom Right
        trianglePath.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        context.setStrokeColor(UIColor("#E0E0E0")!.cgColor)
        trianglePath.stroke()
        // Add line to Bottom Left
        trianglePath.addLine(to: CGPoint(x: 0.0, y: self.bounds.height))
        context.setStrokeColor(UIColor.clear.cgColor)
        trianglePath.stroke()
        // Complete path by drawing path to the Top
        trianglePath.addLine(to: CGPoint(x: self.bounds.width/2, y: 0.0))
        context.setStrokeColor(UIColor("#E0E0E0")!.cgColor)
        trianglePath.stroke()
        
        trianglePath.lineWidth  = 1
        // Set the fill color
        context.setFillColor(UIColor.white.cgColor)
        // Fill the triangle path
        trianglePath.fill()
    }
}
