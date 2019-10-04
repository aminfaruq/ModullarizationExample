//
//  CustomUISlider.swift
//  GITSFramework
//
//  Created by Ajie Pramono Arganata on 24/05/18.
//  Copyright © 2018 GITS Indonesia. All rights reserved.
//

import UIKit

public class CustomUISlider: UISlider {
    @IBInspectable var height: CGFloat = 5.0
//    @IBInspectable var title: String = ""
//    @IBInspectable var titleLeftOrRight: Bool = false
//    @IBInspectable var isPriceValue: Bool = false
//    @IBInspectable var isRoundValue: Bool = false
//    var label: UILabel!
//    var triangle: TriangleView!
//    var labelXMin: CGFloat?
//    var labelXMax: CGFloat?
//    var labelText: ()->String = { "" }
//    public var textValue = ""
    
    public required init?(coder aDecoder: NSCoder) {
//        label = UILabel()
//        triangle = TriangleView()
        super.init(coder: aDecoder)
//        self.addTarget(self, action: #selector(onValueChanged), for: .valueChanged)
    }
    
    func setup(){
//        labelXMin = frame.origin.x + 32
//        labelXMax = frame.origin.x + self.frame.width - 32
//        let labelXOffset: CGFloat = labelXMax! - labelXMin!
//        let valueOffset: CGFloat = CGFloat(self.maximumValue - self.minimumValue)
//        let valueDifference: CGFloat = CGFloat(self.value - self.minimumValue)
//        let valueRatio: CGFloat = CGFloat(valueDifference/valueOffset)
//        let labelXPos = CGFloat(labelXOffset*valueRatio + labelXMin!)
//        let widthLabel = widthForLabel(text: labelText())
//
//        label.frame = CGRect(x: labelXPos, y: self.frame.origin.y + 15, width: widthLabel, height: 25)
////        triangle.frame = CGRect(x: labelXPos - label.frame.width/2, y: self.frame.origin.y+23.5, width: 12, height: 8)
//
////        label.layer.cornerRadius = 6
////        label.layer.borderWidth = 1
////        label.layer.borderColor = UIColor("#E0E0E0")!.cgColor
////        label.layer.masksToBounds = true
//        label.font = UIFont(name: "Arial", size: 14)
//        label.textColor = UIColor("#333333")
//        label.text = self.value.description
//        self.superview!.addSubview(label)
////        self.superview!.addSubview(triangle)
        
    }
    func updateLabel(){
//        label.text = labelText()
//        let widthLabel = widthForLabel(text: labelText())
//        let labelXOffset: CGFloat = labelXMax! - labelXMin!
//        let valueOffset: CGFloat = CGFloat(self.maximumValue - self.minimumValue)
//        let valueDifference: CGFloat = CGFloat(self.value - self.minimumValue)
//        let valueRatio: CGFloat = CGFloat(valueDifference/valueOffset)
//        let labelXPos = CGFloat(labelXOffset*valueRatio + labelXMin!)
        
//        let labelX = labelXPos - label.frame.width/2
//        let labelXa = labelXPos

//        let widthView = self.frame.width
        
//        let diferent = widthView - labelXOffset
        
//        if  labelX >= labelXOffset-diferent {
//            label.frame = CGRect(x: labelXPos - (widthLabel-24), y: self.frame.origin.y + 15, width: widthLabel, height: 25)
//        } else if labelX <= labelXMin!  {
//            label.frame = CGRect(x: labelXa - 24, y: self.frame.origin.y + 15, width: widthLabel, height: 25)
//        } else {
//            label.frame = CGRect(x: labelX, y: self.frame.origin.y + 15, width: widthLabel, height: 25)
//        }
    
//        label.textAlignment = NSTextAlignment.center
//        self.superview!.addSubview(label)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override public func trackRect(forBounds bounds: CGRect) -> CGRect {
        let customBounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: self.height))
        super.trackRect(forBounds: customBounds)
        return customBounds
    }
}
