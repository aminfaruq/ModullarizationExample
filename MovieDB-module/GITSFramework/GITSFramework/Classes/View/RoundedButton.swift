//
//  RoundedBorderButton.swift
//  GITSFramework
//
//  Created by GITS INDONESIA on 4/12/17.
//  Copyright © 2017 GITS Indonesia. All rights reserved.
//

import UIKit
import HexColors
import Material

public class RoundedButton: Button {
    @IBInspectable var cornerRadius: CGFloat = 6.0 //default radius
    @IBInspectable public var borderWidth: CGFloat = 0.0
    var viewLoader: UIView?
    var buttonTitle = ""
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.buttonTitle = self.currentTitle ?? ""
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor?.cgColor
    }
    
    public func setCorner(radius: CGFloat) {
        cornerRadius = radius
        layer.cornerRadius = cornerRadius
    }
    
    public func setBorderWidth(value: CGFloat) {
        borderWidth = value
        layer.borderWidth = borderWidth
    }
    
    public func setLoading(isLoad: Bool) {
        if isLoad {
            let size = self.frame.size.height - 32
            let view = UIView(frame: CGRect(x: 0, y: 0, width: size+12, height: size+16))
            view.backgroundColor = UIColor.clear
            let progress = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            view.addSubview(progress)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.addConstraints([
                NSLayoutConstraint(item: progress, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: size),
                NSLayoutConstraint(item: progress, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: size),
                NSLayoutConstraint(item: progress, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: progress, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)])
            progress.startAnimating()
            self.addSubview(view)
            viewLoader = view
            self.addConstraints([
                NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
            ])
            self.isEnabled = false
            self.setTitle(nil, for: .normal)
        } else {
            self.viewLoader?.removeFromSuperview()
            self.isEnabled = true
            self.setTitle(self.buttonTitle, for: .normal)
        }
    }
}
